import 'package:event/api/repository/faq_category/faq_category.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq_category/faq_category_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';

class FaqCategoryAddScreen extends StatefulWidget {
  final bool? isFromAdd;
  final FaqCategoryData? data;

  const FaqCategoryAddScreen({super.key, this.data, this.isFromAdd});

  @override
  State<FaqCategoryAddScreen> createState() => _FaqCategoryAddScreenState();
}

class _FaqCategoryAddScreenState extends State<FaqCategoryAddScreen> {
  TextEditingController titleController = TextEditingController();

  bool isLoading = false;
  String? faqCategoryStatus;
  @override
  void initState() {
    _checkData();
    if (widget.isFromAdd == false) {
      _getData();
    }
    super.initState();
  }

  _getData() {
    if (widget.data!.title != null && widget.data!.title != "") {
      titleController.text = widget.data!.title!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      faqCategoryStatus = widget.data!.status;
    }
    setState(() {});
  }

  Future _checkData() async {
    if (widget.isFromAdd == true) {
      return;
    }
    if (widget.data!.title != null && widget.data!.title != "") {
      titleController.text = widget.data!.title!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      faqCategoryStatus = widget.data!.status;
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
        title: "Add FAQ Category",
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
                  child: textfield(
                    controller: titleController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Title",
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
                            faqCategoryStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: faqCategoryStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: faqCategoryStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            faqCategoryStatus = value;
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
                        _addFaqCategory();
                      } else {
                        _updateFaqCategory();
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

  Future _addFaqCategory() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (faqCategoryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      int status = faqCategoryStatus == "Publish" ? 1 : 0;
      CommonRes response = await FaqCategoryRepository().addFaqCategoryApiCall(
        status: status,
        title: titleController.text.trim(),
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Faq category added successfully");
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

  Future _updateFaqCategory() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (faqCategoryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      int status = faqCategoryStatus == "Publish" ? 1 : 0;

      CommonRes response = await FaqCategoryRepository()
          .updateFaqCategoryApiCall(
              status: status,
              title: titleController.text.trim(),
              faqCategoryID: widget.data!.id);

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Faq Category updated successfully");
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
