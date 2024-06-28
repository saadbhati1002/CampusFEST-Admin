import 'package:event/api/repository/coupon/coupon.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/coupon/coupon_model.dart';
import 'package:event/screens/image_view/image_view_screen.dart';
import 'package:event/screens/coupon/add_update/add_coupon_list_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key});

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  bool isLoading = false;
  bool isApiCallLoading = false;
  List<CouponData> couponList = [];
  @override
  void initState() {
    _getCouponData();
    super.initState();
  }

  Future _getCouponData() async {
    try {
      setState(() {
        isLoading = true;
      });
      CouponRes response = await CouponRepository().getCouponListApiCall();
      if (response.coupons.isNotEmpty) {
        couponList = response.coupons;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getCouponWithoutLoading() async {
    try {
      CouponRes response = await CouponRepository().getCouponListApiCall();
      if (response.coupons.isNotEmpty) {
        couponList = response.coupons;
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
    Navigator.pop(context, couponList.length);
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
            Navigator.pop(context, couponList.length);
          },
          title: "Coupon Code Management",
        ),
        floatingActionButton: GestureDetector(
          onTap: () async {
            var response = await Get.to(() => const AddCouponListScreen(
                  isFromAdd: true,
                ));
            if (response != null) {
              _getCouponWithoutLoading();
            }
          },
          child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.appColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Coupon",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              )),
        ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: couponList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return couponWidget(
                          data: couponList[index], index: index);
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

  Widget couponWidget({CouponData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (data.img != null) {
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
              imagePath: data!.img ?? "",
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
                  data.title ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.subtitle ?? "",
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Code: ${data.coupon}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Expire Date: ${data.endDate}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Coupon Amount: ${data.couponAmount}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Order Amount: ${data.miniumAmount}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Status: ${data.status}',
                  maxLines: 2,
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
                        var response = await Get.to(() => AddCouponListScreen(
                              isFromAdd: false,
                              data: data,
                            ));
                        if (response != null) {
                          _getCouponWithoutLoading();
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
                    GestureDetector(
                      onTap: () {
                        _categoryDelete(index: index);
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

  Future _categoryDelete({int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await CouponRepository().couponDeleteApiCall(
        couponID: couponList[index!].id,
      );
      if (response.responseCode == "200") {
        couponList.removeAt(index);
        AppConstant.showToastMessage("Coupon deleted successfully");
      } else {
        AppConstant.showToastMessage(response.responseMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiCallLoading = false;
      });
    }
  }
}
