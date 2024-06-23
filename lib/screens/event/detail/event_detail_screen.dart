import 'package:event/api/repository/event/event.dart';
import 'package:event/model/event/details/event_detail_model.dart';
import 'package:event/screens/image_view/image_view_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class EventDetailScreen extends StatefulWidget {
  final String? eventID;
  const EventDetailScreen({super.key, this.eventID});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  String? appName;
  String? packageName;
  Event? eventData;
  String code = "0";
  List event_gallery = [];
  List event_sponsore = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    eventDetailApi();
  }

  eventDetailApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      EventDataRes response =
          await EventRepository().getEvenDetailApiCall(eventID: widget.eventID);
      if (response.responseCode == "200") {
        eventData = response.event;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> _images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: !isLoading
          ? CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: MySliverAppBar(
                      expandedHeight: 200.0,
                      eventData: eventData!,
                      images: _images,
                      share: share),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      //! -------international-------
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: SizedBox(
                              width: Get.width * 0.90,
                              child: Text(
                                eventData?.title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy Medium',
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 50),
                          concert("assets/date.png", eventData?.eventData ?? "",
                              eventData?.eventTime ?? ""),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 50),
                          concert(
                              "assets/direction.png",
                              eventData?.placeName ?? "",
                              eventData?.address ?? ""),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 60),

                          SizedBox(
                              height: MediaQuery.of(context).size.height / 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "About Event".tr,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Gilroy Medium',
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 40),
                          //! About Event
                          Ink(
                            width: Get.width * 0.97,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: HtmlWidget(
                                  eventData?.description ?? "",
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                    fontSize: 12,
                                    fontFamily: 'Gilroy Medium',
                                  ),
                                )),
                          ),
                          event_gallery.isNotEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 50)
                              : const SizedBox(),
                          event_gallery.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gallery".tr,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Gilroy Medium',
                                          color: AppColors.textColor,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Get.to(() => GalleryView(
                                          //       list: event_gallery,
                                          //     ));
                                          setState(() {});
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "View All".tr,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Gilroy Medium',
                                                color: Color(0xff747688),
                                              ),
                                            ),
                                            const Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Color(0xff747688))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          event_gallery.isNotEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40)
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Ink(
                              height: Get.height * 0.14,
                              width: Get.width,
                              child: ListView.builder(
                                itemCount: event_gallery.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, i) {
                                  return galleryEvent(event_gallery, i);
                                },
                              ),
                            ),
                          ),
                          event_gallery.isNotEmpty
                              ? SizedBox(height: Get.height * 0.10)
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            )
          : const ShowProgressBar(),
    );
  }

  galleryEvent(gEvent, i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
          // width: Get.width * 0.28,
          // decoration: BoxDecoration(
          //     // border: Border.all(color: Colors.grey.shade400, width: 1),
          //     borderRadius: BorderRadius.circular(14),
          //     image: DecorationImage(
          //         image: NetworkImage(Config.base_url + gEvent[i]),
          //         fit: BoxFit.cover)),
          ),
    );
  }

  Widget concert(img, name1, name2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        Container(
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 7,
            decoration: const BoxDecoration(
              color: AppColors.blueColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8), child: Image.asset(img))),
        SizedBox(width: MediaQuery.of(context).size.width / 40),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name1,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Gilroy Medium',
                  color: AppColors.textColor)),
          SizedBox(height: MediaQuery.of(context).size.height / 300),
          Ink(
            width: Get.width * 0.705,
            child: Text(
              name2,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: 'Gilroy Medium',
                color: Colors.grey,
              ),
            ),
          ),
        ])
      ]),
    );
  }

  // sponserList(eventSponsore, i) {
  //   print(eventSponsore[i]);
  //   return ListTile(
  //     onTap: () {
  //       print(eventSponsore[i]);
  //       Get.to(ChatPage(
  //           resiverUserId: "1",
  //           resiverUseremail: 'admin',
  //           proPic: eventSponsore[i]["sponsore_img"]));
  //     },
  //     leading: Container(
  //       height: 40,
  //       width: 40,
  //       decoration: BoxDecoration(
  //           color: notifire.getcardcolor,
  //           borderRadius: const BorderRadius.all(Radius.circular(10)),
  //           image: DecorationImage(
  //               image: NetworkImage(
  //                   Config.base_url + eventSponsore[i]["sponsore_img"]),
  //               fit: BoxFit.fill)),
  //       // child: Image(image: NetworkImage(Config.base_url + eventSponsore[i]["sponsore_img"])),
  //     ),
  //     title: Transform.translate(
  //       offset: Offset(-10, 0),
  //       child: Text(eventSponsore[i]["sponsore_title"],
  //           maxLines: 1,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500,
  //               fontFamily: 'Gilroy Medium',
  //               color: notifire.textcolor)),
  //     ),
  //     subtitle: Transform.translate(
  //       offset: Offset(-10, 0),
  //       child: Text("Organizer",
  //           style: TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.w500,
  //               fontFamily: 'Gilroy Medium',
  //               color: Colors.grey)),
  //     ),
  //     trailing: Container(
  //         height: height / 29,
  //         width: width / 6,
  //         // padding: EdgeInsets.all(8),
  //         decoration: BoxDecoration(
  //           color: Color(0xffEAEDFF),
  //           borderRadius: BorderRadius.circular(6),
  //         ),
  //         child: Center(
  //             child: Text('Chat',
  //                 style: TextStyle(color: Color(0xFFFF214A), fontSize: 10)))),
  //   );
  // }

  Future<void> share() async {
    await FlutterShare.share(
        title: '$appName',
        text:
            '${eventData?.title}\n\nDate: ${eventData?.eventData}\n${eventData?.eventTime}\n\nLocation: ${eventData?.address}',
        linkUrl: 'https://app.campusfest.co/',
        chooserTitle: '$appName');
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Event eventData;
  var share;
  var images;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.eventData,
      required this.images,
      required this.share});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            if (eventData.img != null) {
              Get.to(
                () => FullImageScreen(
                  imageUrl: "${AppConstant.imageUrl}${eventData.img}",
                ),
              );
            }
          },
          child: CustomImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            imagePath: eventData.img ?? "",
            borderRadius: 0,
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Container(
              height: 60,
              color: AppColors.redGradient,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textColor,
                        )),
                    const Spacer(),
                    Text(
                      "Event Details".tr,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Gilroy Medium',
                        color: AppColors.textColor,
                      ),
                    ),
                    const Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 45 - shrinkOffset,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Event Details".tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gilroy Medium',
                          color: Colors.white),
                    ),
                  ],
                ),
                // SizedBox(height: height / 20),
                SizedBox(height: MediaQuery.of(context).size.height / 7.5),
                // Center(
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width / 1.4,
                //     height: MediaQuery.of(context).size.height / 14,
                //     child: Card(
                //       // color: notifire.getprimerycolor,
                //       color: notifire.containercolore,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(25.0)),
                //       child: Row(
                //         mainAxisAlignment: eventData["total_member_list"] != "0"
                //             ? MainAxisAlignment.spaceBetween
                //             : MainAxisAlignment.center,
                //         children: [
                //           SizedBox(width: Get.width * 0.01),
                //           eventData["total_member_list"] != "0"
                //               ? FlutterImageStack(
                //                   totalCount: 0,
                //                   itemRadius: 30,
                //                   itemCount: 3,
                //                   itemBorderWidth: 1.5,
                //                   imageList: images)
                //               : const SizedBox(),
                //           SizedBox(width: Get.width * 0.01),
                //           eventData["total_member_list"] != "0"
                //               ? Builder(builder: (context) {
                //                   print(
                //                       "+++++***********-------${Config.userImage}");
                //                   return Text(
                //                     "${eventData["total_member_list"]} + Going",
                //                     style: TextStyle(
                //                         color: const Color(0xff5d56f3),
                //                         fontSize: 12,
                //                         fontFamily: 'Gilroy Bold'),
                //                   );
                //                 })
                //               : const SizedBox(),
                //           eventData["total_member_list"] != "0"
                //               ? SizedBox(width: width / 14)
                //               : const SizedBox(),
                //           InkWell(
                //             onTap: share,
                //             child: Container(
                //               height: height / 29,
                //               width: width / 6,
                //               decoration: BoxDecoration(
                //                   color: Color(0xFFFF214A),
                //                   borderRadius: BorderRadius.circular(6)),
                //               child: Center(
                //                 child: Text("Invite".tr,
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 10,
                //                         fontFamily: 'Gilroy Bold')),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(width: 6),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
