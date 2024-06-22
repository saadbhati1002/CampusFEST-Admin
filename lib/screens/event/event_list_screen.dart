import 'package:event/api/repository/event/event.dart';
import 'package:event/model/event/event_model.dart';
import 'package:event/screens/image_view/image_view_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  bool isLoading = false;
  bool isApiCallLoading = false;
  List<EventData> eventList = [];
  @override
  void initState() {
    _getEventData();
    super.initState();
  }

  Future _getEventData() async {
    try {
      setState(() {
        isLoading = true;
      });
      EventRes response = await EventRepository().getEventListApiCall();
      if (response.events.isNotEmpty) {
        eventList = response.events;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getEventWithoutLoading() async {
    try {
      EventRes response = await EventRepository().getEventListApiCall();
      if (response.events.isNotEmpty) {
        eventList = response.events;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _onBackPress() async {
    Navigator.pop(context, eventList.length);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: titleAppBar(
          onTap: () {
            Navigator.pop(context, eventList.length);
          },
          title: "Event List",
        ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: eventList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return eventWidget(data: eventList[index], index: index);
                    },
                  )
                : ListView.builder(
                    itemCount: 10,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    itemBuilder: (context, index) {
                      return const CommonSkeleton();
                    },
                  ),
            isApiCallLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget eventWidget({EventData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (data!.img != null) {
                Get.to(
                  () => FullImageScreen(
                    imageUrl: "${AppConstant.imageUrl}${data.img}",
                  ),
                );
              }
            },
            child: CustomImage(
              width: MediaQuery.of(context).size.width * .35,
              height: MediaQuery.of(context).size.height,
              imagePath: data?.img ?? "",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data?.title ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data?.eventData ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  data!.eventTime ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Event Status: ${data.eventStatus}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "📌 ${data.address}",
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // var response = await Get.to(() => CategoryAddScreen(
                        //       isFromAdd: false,
                        //       data: data,
                        //     ));
                        // if (response != null) {
                        //   _getCategoryWithoutLoading();
                        // }
                      },
                      child: const Icon(
                        Icons.edit_square,
                        color: AppColors.greyColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // _categoryDelete(index: index);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.greyColor,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
