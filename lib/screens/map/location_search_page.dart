import 'dart:convert';

import 'package:event/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:http/http.dart';

class SearchLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchLocationState();
  }
}

class SearchLocationState extends State<SearchLocation> {
  late GoogleMapController mapController;
  final Set<Marker> markers = Set();
  CameraPosition kGoogle = const CameraPosition(
    target: LatLng(21.2381962, 72.8879607),
    zoom: 6,
  );
  var http = Client();
  bool isLoading = false;
  bool isDispose = false;
  GoogleMapsPlaces? places;
  PlacesSearch? placesSearch;
  List<PlacesSearchResult> searchPredictions = [];
  List<MapBoxPlace> placePred = [];
  PlacesSearchResult? pPredictions;
  MapBoxPlace? mapBoxPredictions;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    places = GoogleMapsPlaces(apiKey: AppConstant.googleMapApiKey);
    searchController.addListener(() async {
      if (!isDispose) {
        if (searchController.text.isNotEmpty) {
          if (places != null) {
            await places!.searchByText(searchController.text).then((value) {
              if (searchController.text.isNotEmpty && mounted) {
                setState(() {
                  searchPredictions.clear();
                  searchPredictions = List.from(value.results);
                });
              } else {
                if (mounted) {
                  setState(() {
                    searchPredictions.clear();
                  });
                }
              }
            }).catchError((e) {
              if (mounted) {
                setState(() {
                  searchPredictions.clear();
                });
              }
            });
          } else if (placesSearch != null) {
            placesSearch!.getPlaces(searchController.text).then((value) {
              if (searchController.text.isNotEmpty && mounted) {
                setState(() {
                  placePred.clear();
                  placePred = List.from(value!);
                });
              } else {
                if (mounted) {
                  setState(() {
                    placePred.clear();
                  });
                }
              }
            }).catchError((e) {
              if (mounted) {
                setState(() {
                  placePred.clear();
                });
              }
            });
          }
        } else {
          if (places != null && mounted) {
            setState(() {
              searchPredictions.clear();
            });
          } else if (placesSearch != null && mounted) {
            setState(() {
              placePred.clear();
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    http.close();
    isDispose = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: GoogleMap(
                  initialCameraPosition: kGoogle,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  // markers: Set<Marker>.of(homePageController.markers),
                  // markers: Set<Marker>.of(markers),
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers),
                  myLocationEnabled: true,
                  compassEnabled: false,
                  zoomGesturesEnabled: true,

                  myLocationButtonEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) async {
                    setState(() {
                      mapController = controller;
                    });

                    mapController
                        .animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: AppConstant.locationLatLong,
                          zoom: 12,
                        ),
                      ),
                    )
                        .then((val) {
                      setState(() {});
                    });
                    setState(() {
                      markers.add(Marker(
                        markerId: MarkerId(
                            AppConstant.locationLatLong.latitude.toString()),
                        position: AppConstant.locationLatLong,
                      ));
                    });
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        readOnly: isLoading,
                        decoration: InputDecoration(
                          hintText: 'Search your location',
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0), width: 1),
                          ),
                        ),
                        controller: searchController,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        primary: true,
                        child: Column(
                          children: [
                            Visibility(
                              visible: (searchPredictions.isNotEmpty),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                child: ListView.separated(
                                  itemCount: searchPredictions.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pPredictions =
                                              searchPredictions[index];
                                        });
                                        Map data = {
                                          "address": searchPredictions[index]
                                              .formattedAddress,
                                          "latitude": pPredictions!
                                              .geometry!.location.lat,
                                          "longitude": pPredictions!
                                              .geometry!.location.lng,
                                        };
                                        Navigator.pop(
                                            context, json.encode(data));
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(
                                              child: Icon(Icons.location_on)),
                                          const SizedBox(
                                            width: 16.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${searchPredictions[index].formattedAddress}',
                                              overflow: TextOverflow.ellipsis,
                                              // style: Theme.of(context)
                                              //     .textTheme
                                              //     .caption
                                              //     .copyWith(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 1,
                                      color: Colors.black45,
                                    );
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible: (placePred.isNotEmpty),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                child: ListView.separated(
                                  itemCount: placePred.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          mapBoxPredictions = placePred[index];
                                        });
                                        // Navigator.pop(
                                        //     context,
                                        //     BackLatLng(
                                        //         mapBoxPredictions!
                                        //             .geometry!.coordinates![1],
                                        //         mapBoxPredictions!
                                        //             .geometry!.coordinates![0],
                                        //         placePred[index].placeName));
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: Image.asset(
                                              'images/map_pin.png',
                                              scale: 3,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${placePred[index].placeName}',
                                              overflow: TextOverflow.ellipsis,
                                              // style: Theme.of(context)
                                              //     .textTheme
                                              //     .caption
                                              //     .copyWith(fontSize: 14),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 1,
                                      color: Colors.black45,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
