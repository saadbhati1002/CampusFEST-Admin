import 'dart:convert';
import 'dart:io';
import 'package:event/api/network/category/category.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({super.key});

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  TextEditingController titleController = TextEditingController();
  File? categoryImage, categoryCoverImage;
  bool isLoading = false;
  String? categoryStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: titleAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Add Category",
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
                            categoryStatus ?? "Status",
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
                commonRow(
                  imageFile: categoryImage,
                  index: 1,
                  title: 'Category Image',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                commonRow(
                  imageFile: categoryCoverImage,
                  index: 2,
                  title: 'Cover Image',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      _addCategory();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.appColor,
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
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

  Widget commonRow({String? title, int? index, File? imageFile}) {
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
            imageFile != null
                ? Container(
                    height: MediaQuery.of(context).size.height * .23,
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: FileImage(imageFile), fit: BoxFit.cover),
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
          ],
        ),
      ),
    );
  }

  Future getImage({int? index}) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (index == 1) {
        categoryImage = File(image.path);
      } else if (index == 2) {
        categoryCoverImage = File(image.path);
      }
      setState(() {});
    }
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
    if (categoryImage == null) {
      AppConstant.showToastMessage("Please select image");
      return;
    }
    if (categoryCoverImage == null) {
      AppConstant.showToastMessage("Please select cover image");
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
}
