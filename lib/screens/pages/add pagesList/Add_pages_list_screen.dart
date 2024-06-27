import 'dart:convert';
import 'dart:io';

import 'package:event/api/network/category/category.dart';
import 'package:event/model/category/category_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPagesListScreen extends StatefulWidget {
  final bool? isFromAdd;
  final CategoryData? data;
  const AddPagesListScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddPagesListScreen> createState() => _AddPagesListScreenState();
}

class _AddPagesListScreenState extends State<AddPagesListScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? categoryImage, categoryCoverImage;
  bool isLoading = false;
  String? categoryStatus;
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
    if (widget.data!.status != null && widget.data!.status != null) {
      categoryStatus = widget.data!.status;
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Page Title",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: titleController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Enter category Name",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Page Description",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Page Status",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
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
                            categoryStatus ?? "Select Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: categoryStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: categoryStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            categoryStatus = value;
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
                        _addCategory();
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

  Future _addCategory() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (categoryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      int status = categoryStatus == "Publish" ? 1 : 0;
      List<int> imageBytes = categoryImage!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      List<int> imageBytesCover = categoryCoverImage!.readAsBytesSync();
      String base64ImageCover = base64Encode(imageBytesCover);

      var request = http.Request('POST',
          Uri.parse(AppConstant.baseUrl + CategoryNetwork.addCategoryUrl));
      request.body =
          '''{"title": "${titleController.text.toString()}","status":$status, "img": "$base64Image", "cover_img": "$base64ImageCover"}''';
      request.headers.addAll(AppConstant.headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        AppConstant.showToastMessage("Category added successfully");
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
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (categoryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    print(
        "${AppConstant.baseUrl}${CategoryNetwork.updateCategoryUrl}${widget.data!.id}");
    var request = http.Request(
        'PUT',
        Uri.parse(
            "${AppConstant.baseUrl}${CategoryNetwork.updateCategoryUrl}${widget.data!.id}"));
    int status = categoryStatus == "Publish" ? 1 : 0;
    request.body =
        '''{"title": "${titleController.text.toString()}","status":$status,"img":"","cover_img":""}''';

    if (categoryImage != null && categoryCoverImage != null) {
      List<int> imageBytesCover = categoryCoverImage!.readAsBytesSync();
      String base64ImageCover = base64Encode(imageBytesCover);
      List<int> imageBytes = categoryImage!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      request.body =
          '''{"title": "${titleController.text.toString()}","status":$status, "img": "$base64Image", "cover_img": "$base64ImageCover"}''';
    } else {
      if (categoryImage != null) {
        List<int> imageBytes = categoryImage!.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        request.body =
            '''{"title": "${titleController.text.toString()}","status":$status, "img": "$base64Image","cover_img":"" }''';
      }
      if (categoryCoverImage != null) {
        List<int> imageBytesCover = categoryCoverImage!.readAsBytesSync();
        String base64ImageCover = base64Encode(imageBytesCover);

        request.body =
            '''{"title": "${titleController.text.toString()}","status":$status,  "cover_img": "$base64ImageCover","img":""}''';
      }
    }

    try {
      setState(() {
        isLoading = true;
      });

      request.headers.addAll(AppConstant.headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        AppConstant.showToastMessage("Category updated successfully");
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
