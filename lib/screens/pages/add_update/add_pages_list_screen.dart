import 'dart:io';
import 'package:event/api/repository/page/page.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/page/page_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';

class AddPagesListScreen extends StatefulWidget {
  final bool? isFromAdd;
  final PagesData? data;
  const AddPagesListScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddPagesListScreen> createState() => _AddPagesListScreenState();
}

class _AddPagesListScreenState extends State<AddPagesListScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? categoryImage, categoryCoverImage;
  bool isLoading = false;
  String? pageStatus;
  @override
  void initState() {
    _checkData();
    super.initState();
  }

  Future _checkData() async {
    if (widget.isFromAdd == true) {
      return;
    }
    if (widget.data!.title != null && widget.data!.title != "") {
      titleController.text = widget.data!.title!;
    }
    if (widget.data!.description != null && widget.data!.description != "") {
      descriptionController.text = widget.data!.description!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      pageStatus = widget.data!.status;
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
        title: "Page Management",
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
                    text: "Enter Page ",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    multiLines: true,
                    controller: descriptionController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Enter Description",
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
                            pageStatus ?? "Select Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: pageStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: pageStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            pageStatus = value;
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
                        _addPage();
                      } else {
                        _updatePage();
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

  Future _addPage() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter description");
      return;
    }
    if (pageStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      int status = pageStatus == "Publish" ? 1 : 0;
      CommonRes response = await PageRepository().addPageApiCall(
          status: status,
          title: titleController.text.trim(),
          description: descriptionController.text.trim());

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Page added successfully");
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

  Future _updatePage() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter description");
      return;
    }
    if (pageStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      int status = pageStatus == "Publish" ? 1 : 0;
      CommonRes response = await PageRepository().updatePageApiCall(
        status: status,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        pageID: widget.data!.id,
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Page updated successfully");
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
