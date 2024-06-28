import 'dart:convert';
import 'dart:io';
import 'package:event/api/repository/coupon/coupon.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/coupon/coupon_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

class AddCouponListScreen extends StatefulWidget {
  final bool? isFromAdd;
  final CouponData? data;
  const AddCouponListScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddCouponListScreen> createState() => _AddCouponListScreenState();
}

class _AddCouponListScreenState extends State<AddCouponListScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController couponDateController = TextEditingController();
  TextEditingController minOrderAmountController = TextEditingController();
  TextEditingController couponValueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? couponImage;
  bool isLoading = false;
  String? couponStatus;
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
    if (widget.data!.subtitle != null && widget.data!.subtitle != "") {
      subtitleController.text = widget.data!.subtitle!;
    }
    if (widget.data!.coupon != null && widget.data!.coupon != "") {
      couponCodeController.text = widget.data!.coupon!;
    }
    if (widget.data!.couponAmount != null && widget.data!.couponAmount != "") {
      couponValueController.text = widget.data!.couponAmount!;
    }
    if (widget.data!.miniumAmount != null && widget.data!.miniumAmount != "") {
      minOrderAmountController.text = widget.data!.miniumAmount!;
    }
    if (widget.data!.description != null && widget.data!.description != "") {
      descriptionController.text = widget.data!.description!;
    }
    if (widget.data!.endDate != null && widget.data!.endDate != "") {
      couponDateController.text = widget.data!.endDate!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      couponStatus = widget.data!.status;
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
        title: "Add Coupon",
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
                    text: "Coupon title",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: subtitleController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Coupon Subtitle",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: couponCodeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Coupon Code",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _selectDate(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: couponDateController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Coupon Expiry Date",
                    suffix: const Icon(
                      Icons.calendar_month,
                      color: AppColors.greyColor,
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
                            couponStatus ?? "Coupon Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: couponStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: couponStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            couponStatus = value;
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
                    controller: minOrderAmountController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    keyboardType: TextInputType.number,
                    text: "Coupon Min Order Amount",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: couponValueController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    keyboardType: TextInputType.number,
                    text: "Coupon Value",
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
                    text: "Description",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                commonRow(
                    imageFile: couponImage,
                    index: 1,
                    title: 'Coupon Image',
                    imagePath: widget.data?.img ?? ''),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isFromAdd == true) {
                        _addCoupon();
                      } else {
                        _updateCoupon();
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Widget commonRow(
      {String? title, int? index, File? imageFile, String? imagePath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .42,
              child: Text(
                title!,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontFamily: "Gilroy Medium",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (widget.isFromAdd == true) ...[
              imageFile != null
                  ? GestureDetector(
                      onTap: () {
                        getImage(index: index);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .23,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: FileImage(imageFile), fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        getImage(index: index);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                          color: AppColors.appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Upload",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Gilroy Medium",
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
            ] else ...[
              imageFile != null
                  ? GestureDetector(
                      onTap: () {
                        getImage(index: index);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .23,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: FileImage(imageFile), fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        getImage(index: index);
                      },
                      child: CustomImage(
                        height: MediaQuery.of(context).size.height * .23,
                        width: MediaQuery.of(context).size.width * .4,
                        borderRadius: 10,
                        imagePath: imagePath,
                      ),
                    )
            ],
          ],
        ),
      ),
    );
  }

  Future getImage({int? index}) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (index == 1) {
        couponImage = File(image.path);
      } else if (index == 2) {
        couponImage = File(image.path);
      }
      setState(() {});
    }
  }

  Future _addCoupon() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter subtitle");
      return;
    }
    if (couponCodeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter coupon code");
      return;
    }
    if (couponDateController.text.isEmpty) {
      AppConstant.showToastMessage("Please select expire date");
      return;
    }
    if (couponStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    if (minOrderAmountController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter minium order amount");
      return;
    }
    if (couponValueController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter order amount");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter description");
      return;
    }
    if (couponImage == null) {
      AppConstant.showToastMessage("Please select image");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      int status = couponStatus == "Publish" ? 1 : 0;
      List<int> imageBytes = couponImage!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      CommonRes response = await CouponRepository().addCouponApiCall(
        status: status,
        title: titleController.text.trim(),
        img: base64Image,
        couponAmount: couponValueController.text.trim(),
        couponCode: couponCodeController.text.trim().toUpperCase(),
        description: descriptionController.text.trim(),
        expireData: couponDateController.text.toString(),
        miniumOrderAMount: minOrderAmountController.text.trim(),
        subtitle: subtitleController.text.trim(),
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Coupon added successfully");
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

  Future _updateCoupon() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter subtitle");
      return;
    }
    if (couponCodeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter coupon code");
      return;
    }
    if (couponDateController.text.isEmpty) {
      AppConstant.showToastMessage("Please select expire date");
      return;
    }
    if (couponStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    if (minOrderAmountController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter minium order amount");
      return;
    }
    if (couponValueController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter order amount");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter description");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      String? base64Image;
      int status = couponStatus == "Publish" ? 1 : 0;

      if (couponImage != null) {
        List<int> imageBytes = couponImage!.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
      }
      CommonRes response = await CouponRepository().updateCouponApiCall(
        status: status,
        title: titleController.text.trim(),
        img: base64Image,
        couponAmount: couponValueController.text.trim(),
        couponCode: couponCodeController.text.trim().toUpperCase(),
        description: descriptionController.text.trim(),
        expireData: couponDateController.text.toString(),
        miniumOrderAMount: minOrderAmountController.text.trim(),
        subtitle: subtitleController.text.trim(),
        couponID: widget.data!.id,
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Coupon updated successfully");
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      couponDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}
