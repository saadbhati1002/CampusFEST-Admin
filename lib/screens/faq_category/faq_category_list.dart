import 'package:event/api/repository/category/category.dart';
import 'package:event/api/repository/faq_category/faq_category.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq_category/faq_category_model.dart';
import 'package:event/screens/faq_category/add_update/faq_category_add_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqCategoryListScreen extends StatefulWidget {
  const FaqCategoryListScreen({super.key});

  @override
  State<FaqCategoryListScreen> createState() => _FaqCategoryListScreenState();
}

class _FaqCategoryListScreenState extends State<FaqCategoryListScreen> {
  bool isLoading = false;
  bool isApiCallLoading = false;
  List<FaqCategoryData> categoryList = [];
  @override
  void initState() {
    _getFaqCategoryData();
    super.initState();
  }

  Future _getFaqCategoryData() async {
    try {
      setState(() {
        isLoading = true;
      });
      FaqCategoryRes response =
          await FaqCategoryRepository().getFaqCategoryListApiCall();
      if (response.categories.isNotEmpty) {
        categoryList = response.categories;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getFaqCategoryWithoutLoading() async {
    try {
      FaqCategoryRes response =
          await FaqCategoryRepository().getFaqCategoryListApiCall();
      if (response.categories.isNotEmpty) {
        categoryList = response.categories;
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
    Navigator.pop(context, categoryList.length);
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
            Navigator.pop(context, categoryList.length);
          },
          title: "FAQ Category",
        ),
        floatingActionButton: GestureDetector(
          onTap: () async {
            var response = await Get.to(() => const FaqCategoryAddScreen(
                  isFromAdd: true,
                ));
            if (response != null) {
              _getFaqCategoryWithoutLoading();
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
                    "Add Category",
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
                    itemCount: categoryList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return categoryWidget(
                          data: categoryList[index], index: index);
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

  Widget categoryWidget({FaqCategoryData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  "title",
                  // data.title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "status",
                  // 'Status: ${data.status}',
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
                        // var response = await Get.to(() => CategoryAddScreen(
                        //       isFromAdd: false,
                        //       data: data,
                        //     ));
                        // if (response != null) {
                        //   _getFaqCategoryWithoutLoading();
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

      CommonRes response = await CategoryRepository().categoryDeleteApiCall(
        userID: categoryList[index!].id,
      );
      if (response.responseCode == "200") {
        categoryList.removeAt(index);
        AppConstant.showToastMessage("Category deleted successfully");
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
