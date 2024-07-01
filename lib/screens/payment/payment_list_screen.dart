import 'package:event/api/repository/payment/payment.dart';
import 'package:event/model/payment/payment_model.dart';
import 'package:event/screens/image_view/image_view_screen.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:flutter/material.dart';
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
  List<PaymentData> paymentList = [];
  @override
  void initState() {
    _getPaymentData();
    super.initState();
  }

  Future _getPaymentData() async {
    try {
      setState(() {
        isLoading = true;
      });
      PaymentRes response = await PaymentRepository().getPaymentListApiCall();
      if (response.payments.isNotEmpty) {
        paymentList = response.payments;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getPaymentWithoutLoading() async {
    try {
      PaymentRes response = await PaymentRepository().getPaymentListApiCall();
      if (response.payments.isNotEmpty) {
        paymentList = response.payments;
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
    Navigator.pop(context, paymentList.length);
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
            Navigator.pop(context, paymentList.length);
          },
          title: "Payment List",
        ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: paymentList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return paymentWidget(
                          data: paymentList[index], index: index);
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

  Widget paymentWidget({PaymentData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .14,
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
              width: MediaQuery.of(context).size.width * .27,
              height: MediaQuery.of(context).size.height,
              imagePath: data!.img ?? "",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .64,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.subtitle ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Status: ${data.status}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     GestureDetector(
                //       onTap: () async {
                //         // var response = await Get.to(
                //         //   () => AddSponsorsListScreen(
                //         //     isFromAdd: false,
                //         //     data: data,
                //         //   ),
                //         // );
                //         // if (response != null) {
                //         //   _getPaymentWithoutLoading();
                //         // }
                //       },
                //       child: const Icon(
                //         Icons.edit_square,
                //         color: AppColors.greyColor,
                //         size: 20,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
