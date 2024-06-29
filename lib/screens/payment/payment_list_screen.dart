import 'package:event/api/repository/sponsor/sponsor.dart';
import 'package:flutter/material.dart';
import 'package:event/model/sponsor/sponsor_model.dart';
import 'package:event/screens/sponsors/add_update/add_sponsors_list_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:get/get.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  bool isLoading = false;
  bool isApiCallLoading = false;
  List<SponsorData> sponsorList = [];
  @override
  void initState() {
    _getSponsorData();
    super.initState();
  }

  Future _getSponsorData() async {
    try {
      setState(() {
        isLoading = true;
      });
      SponsorRes response = await SponsorRepository().getSponsorListApiCall();
      if (response.sponsors.isNotEmpty) {
        sponsorList = response.sponsors;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getSponsorWithoutLoading() async {
    try {
      SponsorRes response = await SponsorRepository().getSponsorListApiCall();
      if (response.sponsors.isNotEmpty) {
        sponsorList = response.sponsors;
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
    Navigator.pop(context, sponsorList.length);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: titleAppBar(
          onTap: () {
            Navigator.pop(context, sponsorList.length);
          },
          title: "Payment List",
        ),
        // floatingActionButton: GestureDetector(
        //   onTap: () async {
        //     var response = await Get.to(() => const AddTypePriceScreen(
        //           isFromAdd: true,
        //         ));
        //     if (response != null) {
        //       _getSponsorWithoutLoading();
        //     }
        //   },
        //   child: Container(
        //       height: 38,
        //       padding: const EdgeInsets.symmetric(horizontal: 15),
        //       decoration: BoxDecoration(
        //         color: AppColors.appColor,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: const Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Add Type & Price ",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: AppColors.whiteColor,
        //             ),
        //           ),
        //         ],
        //       )),
        // ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: sponsorList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return sponsorWidget(
                          data: sponsorList[index], index: index);
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

  Widget sponsorWidget({SponsorData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "payment gateway name",
                  // data.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "payment gateway subtitle",
                  // 'Event Name: ${data.eventName}',
                  maxLines: 21,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "payment gateway image",
                  // 'Status: ${data.status}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "payment gateway status",
                  // 'Status: ${data.status}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "show on wallet",
                  // 'Status: ${data.status}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
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
                        var response = await Get.to(
                          () => AddSponsorsListScreen(
                            isFromAdd: false,
                            data: data,
                          ),
                        );
                        if (response != null) {
                          _getSponsorWithoutLoading();
                        }
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
                    // GestureDetector(
                    //   onTap: () {
                    //     _sponsorDelete(index: index);
                    //   },
                    //   child: const Icon(
                    //     Icons.delete,
                    //     color: AppColors.greyColor,
                    //     size: 20,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future _sponsorDelete({int? index}) async {
  //   try {
  //     setState(() {
  //       isApiCallLoading = true;
  //     });

  //     CommonRes response = await SponsorRepository().sponsorDeleteApiCall(
  //       sponsorID: sponsorList[index!].id,
  //     );
  //     if (response.responseCode == "200") {
  //       sponsorList.removeAt(index);
  //       AppConstant.showToastMessage("Sponsor deleted successfully");
  //     } else {
  //       AppConstant.showToastMessage(response.responseMsg);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     setState(() {
  //       isApiCallLoading = false;
  //     });
  //   }
  // }
}
