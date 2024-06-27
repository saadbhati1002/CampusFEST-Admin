import 'dart:io';
import 'package:event/api/repository/faq/faq.dart';
import 'package:event/api/repository/faq_category/faq_category.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq/faq_model.dart';
import 'package:event/model/faq_category/faq_category_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';

class FaqAddScreen extends StatefulWidget {
  final bool? isFromAdd;
  final FaqData? data;
  const FaqAddScreen({super.key, this.data, this.isFromAdd});

  @override
  State<FaqAddScreen> createState() => _FaqAddScreenState();
}

class _FaqAddScreenState extends State<FaqAddScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  File? categoryImage, categoryCoverImage;
  bool isLoading = false;
  String? faqStatus;
  FaqCategoryData? selectedCategory;
  List<FaqCategoryData> categoryList = [];

  @override
  void initState() {
    _getCategoryData();
    _checkData();
    super.initState();
  }

  Future _getCategoryData() async {
    try {
      setState(() {
        isLoading = true;
      });
      FaqCategoryRes response =
          await FaqCategoryRepository().getFaqCategoryListApiCall();
      if (response.categories.isNotEmpty) {
        categoryList = response.categories;
        if (widget.isFromAdd == false) {
          for (int i = 0; i < categoryList.length; i++) {
            if (categoryList[i].id == widget.data!.catID) {
              selectedCategory = categoryList[i];
            }
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _checkData() async {
    if (widget.isFromAdd == true) {
      return;
    }
    if (widget.data!.question != null && widget.data!.question != "") {
      questionController.text = widget.data!.question!;
    }
    if (widget.data!.answer != null && widget.data!.answer != "") {
      answerController.text = widget.data!.answer!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      faqStatus = widget.data!.status;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: titleAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Add FAQ",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.greyColor,
                      ),
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: AppColors.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.greyColor,
                          ),
                          isExpanded: true,
                          items: categoryList.map((FaqCategoryData value) {
                            return DropdownMenuItem<FaqCategoryData>(
                              value: value,
                              child: Text(
                                value.title ?? "",
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            selectedCategory?.title ?? "Select Category",
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedCategory == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: selectedCategory == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: questionController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Question",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: answerController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Answer",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.greyColor,
                      ),
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: AppColors.whiteColor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.greyColor,
                          ),
                          isExpanded: true,
                          items: <String>[
                            'Publish',
                            'Unpublished',
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          style: const TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          hint: Text(
                            faqStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: faqStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: faqStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            faqStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isFromAdd == true) {
                        _addFaq();
                      } else {
                        _updateCategory();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.appColor,
                      ),
                      child: Center(
                        child: Text(
                          widget.isFromAdd == true ? "Add" : "Update",
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontFamily: "Gilroy Bold"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Future _addFaq() async {
    if (selectedCategory == null) {
      AppConstant.showToastMessage("Please select category");
      return;
    }
    if (questionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter question");
      return;
    }
    if (answerController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter answer");
      return;
    }
    if (faqStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      int status = faqStatus == "Publish" ? 1 : 0;
      CommonRes response = await FaqRepository().addFaqApiCall(
          status: status,
          question: questionController.text.trim(),
          answer: answerController.text.trim(),
          catID: selectedCategory!.id);

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Faq added successfully");
        Navigator.pop(context, 1);
      } else {
        AppConstant.showToastMessage("Getting some error please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _updateCategory() async {
    if (selectedCategory == null) {
      AppConstant.showToastMessage("Please select category");
      return;
    }
    if (questionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter question");
      return;
    }
    if (answerController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter answer");
      return;
    }
    if (faqStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      int status = faqStatus == "Publish" ? 1 : 0;

      CommonRes response = await FaqRepository().updateFaqApiCall(
        status: status,
        question: questionController.text.trim(),
        answer: answerController.text.trim(),
        catID: selectedCategory!.id,
        faqID: widget.data!.id,
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Faq updated successfully");
        Navigator.pop(context, 1);
      } else {
        AppConstant.showToastMessage("Getting some error please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
