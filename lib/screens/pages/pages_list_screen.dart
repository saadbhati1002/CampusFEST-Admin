import 'package:event/api/repository/page/page.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/page/page_model.dart';
import 'package:event/screens/pages/add_update/add_pages_list_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesListScreen extends StatefulWidget {
  const PagesListScreen({super.key});

  @override
  State<PagesListScreen> createState() => _PagesListScreenState();
}

class _PagesListScreenState extends State<PagesListScreen> {
  bool isLoading = false;
  bool isApiCallLoading = false;
  List<PagesData> pagesList = [];
  @override
  void initState() {
    _getPagesData();
    super.initState();
  }

  Future _getPagesData() async {
    try {
      setState(() {
        isLoading = true;
      });
      PageRes response = await PageRepository().getPageListApiCall();
      if (response.pages.isNotEmpty) {
        pagesList = response.pages;
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
      PageRes response = await PageRepository().getPageListApiCall();
      if (response.pages.isNotEmpty) {
        pagesList = response.pages;
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
    Navigator.pop(context, pagesList.length);
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
            Navigator.pop(context, pagesList.length);
          },
          title: "Pages Management",
        ),
        floatingActionButton: GestureDetector(
          onTap: () async {
            var response = await Get.to(() => const AddPagesListScreen(
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
                    "Add Pages",
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
                    itemCount: pagesList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return pageWidget(data: pagesList[index], index: index);
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

  Widget pageWidget({PagesData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .15,
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
                  data?.title ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data!.description ?? '',
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14,
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
                        var response = await Get.to(() => AddPagesListScreen(
                              isFromAdd: false,
                              data: data,
                            ));
                        if (response != null) {
                          _getFaqCategoryWithoutLoading();
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
                        _pageDelete(index: index);
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

  Future _pageDelete({int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await PageRepository().pageDeleteApiCall(
        pageID: pagesList[index!].id,
      );
      if (response.responseCode == "200") {
        pagesList.removeAt(index);
        AppConstant.showToastMessage("Page deleted successfully");
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
