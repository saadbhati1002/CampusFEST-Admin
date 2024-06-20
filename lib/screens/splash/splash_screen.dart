import 'dart:async';
import 'dart:convert';

import 'package:event/model/auth/login_model.dart';
import 'package:event/screens/auth/login/login.dart';
import 'package:event/screens/dashboard/dashboard_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;

  late StreamSubscription<Position> positionStream;
  @override
  void initState() {
    checkGps();
    _checkUserLogin();
    super.initState();
  }

  Future _checkUserLogin() async {
    try {
      var response = await AppConstant.getUserDetail();
      if (response != null && response != "null") {
        LoginRes responseUser = LoginRes.fromJson(jsonDecode(response));
        AppConstant.userData = responseUser.adminLogin;
        AppConstant.bearerToken = responseUser.adminLogin!.id!;
        Get.to(() => const DashBoardScreen());
      } else {
        Get.to(() => const LoginScreen());
      }
    } catch (e) {
      Get.to(() => const LoginScreen());
    }
  }

//! permission handel
  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
        } else if (permission == LocationPermission.deniedForever) {
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }
      if (hasPermission) {
        setState(() {});
        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }
    setState(() {});
  }

//! get lat long
  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    AppConstant.locationLatLong = LatLng(position.latitude, position.longitude);

    var latlong = LatLng(position.latitude, position.longitude);
    getAddressFromLatLong(latlong);

    setState(() {});
  }

  Future<void> getAddressFromLatLong(LatLng latLng) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placeMark.isNotEmpty) {
      Placemark place = placeMark[0];
      String city = place.locality.toString();
      String country = place.country.toString();
      var currentAddress = city + ((city.isNotEmpty) ? ", " : "") + country;
      AppConstant.currentAddress = currentAddress;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Container(
          color: AppColors.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset("image/get_event.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
