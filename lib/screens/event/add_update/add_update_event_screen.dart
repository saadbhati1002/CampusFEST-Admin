import 'dart:convert';
import 'dart:io';
import 'package:event/api/repository/category/category.dart';
import 'package:event/api/repository/event/event.dart';
import 'package:event/model/category/category_model.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/event/event_model.dart';
import 'package:event/screens/map/location_search_page.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddUpdateEventScreen extends StatefulWidget {
  final bool? isFromAdd;
  final EventData? data;
  const AddUpdateEventScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddUpdateEventScreen> createState() => _AddUpdateEventScreenState();
}

class _AddUpdateEventScreenState extends State<AddUpdateEventScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventStatTimeController = TextEditingController();
  TextEditingController eventEndTimeController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController disclaimerController = TextEditingController();
  String? eventStatus;
  CategoryData? selectedCategory;
  bool isLoading = false;
  List<CategoryData> categoryList = [];
  File? eventImage, eventCoverImage;

  @override
  void initState() {
    _getCategoryData();
    if (widget.isFromAdd == false) {
      _getData();
    }
    super.initState();
  }

  _getData() {
    if (widget.data!.title != null && widget.data!.title != "") {
      titleController.text = widget.data!.title!;
    }
    if (widget.data!.eventData != null && widget.data!.eventData != "") {
      eventDateController.text = widget.data!.eventData!;
    }
    if (widget.data!.startTime != null && widget.data!.startTime != "") {
      eventStatTimeController.text = widget.data!.startTime!;
    }
    if (widget.data!.endTime != null && widget.data!.endTime != "") {
      eventEndTimeController.text = widget.data!.endTime!;
    }
    if (widget.data!.eventPlace != null && widget.data!.eventPlace != "") {
      placeController.text = widget.data!.eventData!;
    }
    if (widget.data!.address != null && widget.data!.address != "") {
      addressController.text = widget.data!.address!;
    }
    if (widget.data!.latitude != null && widget.data!.latitude != "") {
      latitudeController.text = widget.data!.latitude!;
    }
    if (widget.data!.longitude != null && widget.data!.longitude != "") {
      longitudeController.text = widget.data!.longitude!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      eventStatus = widget.data!.status;
    }
    if (widget.data!.description != null && widget.data!.description != null) {
      descriptionController.text = widget.data!.description!;
    }
    if (widget.data!.disclaimer != null && widget.data!.disclaimer != null) {
      disclaimerController.text = widget.data!.disclaimer!;
    }
    setState(() {});
  }

  Future _getCategoryData() async {
    try {
      setState(() {
        isLoading = true;
      });
      CategoryRes response =
          await CategoryRepository().getCategoryListApiCall();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Add Event",
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
                          items: categoryList.map((CategoryData value) {
                            return DropdownMenuItem<CategoryData>(
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
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _selectDate(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: eventDateController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Start Date",
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
                  child: textfield(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      _selectStartTime(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: eventStatTimeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Start Time",
                    suffix: const Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.greyColor,
                    ),
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

                      _selectEndTime(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: eventEndTimeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "End Time",
                    suffix: const Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: placeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Place Name",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: addressController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Address",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var response = await Get.to(() => SearchLocation());
                          if (response != null) {
                            final responseData = jsonDecode(response);
                            addressController.text = responseData["address"];
                            latitudeController.text =
                                responseData["latitude"].toString();
                            longitudeController.text =
                                responseData["longitude"].toString();
                            setState(() {});
                          }
                        },
                        child: const Text(
                          "Choose From Map",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.appColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: latitudeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Latitude",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    controller: longitudeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Longitude",
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
                            eventStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: eventStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: eventStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            eventStatus = value;
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
                      controller: descriptionController,
                      fieldColor: AppColors.bgColor,
                      labelColor: AppColors.greyColor,
                      text: "Description",
                      multiLines: true),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                      controller: disclaimerController,
                      fieldColor: AppColors.bgColor,
                      labelColor: AppColors.greyColor,
                      text: "Disclaimer",
                      multiLines: true),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                commonRow(
                  imageFile: eventImage,
                  index: 1,
                  title: 'Event Image',
                  imagePath: widget.data?.img ?? '',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                commonRow(
                  imageFile: eventCoverImage,
                  index: 2,
                  title: 'Cover Image',
                  imagePath: widget.data?.coverImg ?? '',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isFromAdd == true) {
                        _addEvent();
                      } else {
                        _updateEvent();
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
                  height: MediaQuery.of(context).size.height * 0.03,
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
        eventImage = File(image.path);
      } else if (index == 2) {
        eventCoverImage = File(image.path);
      }
      setState(() {});
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
      eventDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  _selectStartTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      DateTime tempDate = DateFormat("hh:mm").parse(
          selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
      var dateFormat = DateFormat("h:mma"); // you can change the format here

      eventStatTimeController.text = dateFormat.format(tempDate);
    }
  }

  _selectEndTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      DateTime tempDate = DateFormat("hh:mm").parse(
          selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
      var dateFormat = DateFormat("h:mma"); // you can change the format here

      eventEndTimeController.text = dateFormat.format(tempDate);
    }
  }

  Future _addEvent() async {
    if (titleController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter title");
      return;
    }
    if (selectedCategory == null) {
      AppConstant.showToastMessage("Please select category");
      return;
    }

    if (eventDateController.text.isEmpty) {
      AppConstant.showToastMessage("Please select start date");
      return;
    }
    if (eventStatTimeController.text.isEmpty) {
      AppConstant.showToastMessage("Please select start time");
      return;
    }
    if (eventEndTimeController.text.isEmpty) {
      AppConstant.showToastMessage("Please select end time");
      return;
    }
    if (placeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter place name");
      return;
    }
    if (addressController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter location address");
      return;
    }
    if (latitudeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter location latitude");
      return;
    }
    if (longitudeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter location longitude");
      return;
    }
    if (eventStatus == null) {
      AppConstant.showToastMessage("Please select event status");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter event description");
      return;
    }
    if (disclaimerController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter event disclaimer");
      return;
    }
    if (eventImage == null) {
      AppConstant.showToastMessage("Please select event image");
      return;
    }
    if (eventCoverImage == null) {
      AppConstant.showToastMessage("Please select cover image");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });

      int status = eventStatus == "Publish" ? 1 : 0;
      var df = DateFormat("h:mma");
      var startTime = df.parse(eventStatTimeController.text);
      var endTime = df.parse(eventEndTimeController.text);

      List<int> imageBytes = eventImage!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      List<int> imageBytesCover = eventCoverImage!.readAsBytesSync();
      String base64ImageCover = base64Encode(imageBytesCover);
      CommonRes response = await EventRepository().eventAddApiCall(
        address: addressController.text.trim(),
        categoryID: selectedCategory!.id,
        coverImage: base64ImageCover,
        date: eventDateController.text.trim(),
        description: descriptionController.text.trim(),
        disclaimer: disclaimerController.text.trim(),
        endTime: "${DateFormat('HH:mm').format(endTime)}:00",
        image: base64Image,
        latitude: latitudeController.text.trim(),
        longitude: longitudeController.text.trim(),
        placeName: placeController.text.trim(),
        statTime: "${DateFormat('HH:mm').format(startTime)}:00",
        status: status,
        title: titleController.text.trim(),
      );
      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Event added successfully");
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

  Future _updateEvent() async {
    try {
      setState(() {
        isLoading = true;
      });

      int status = eventStatus == "Publish" ? 1 : 0;
      var df = DateFormat("h:mma");
      var startTime = df.parse(eventStatTimeController.text);
      var endTime = df.parse(eventEndTimeController.text);
      List<int> imageBytesCover = [];
      String? base64ImageCover;
      List<int> imageBytes = [];
      String? base64Image;
      if (eventImage != null) {
        imageBytes = eventImage!.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
      }
      if (eventCoverImage != null) {
        imageBytesCover = eventCoverImage!.readAsBytesSync();
        base64ImageCover = base64Encode(imageBytesCover);
      }
      CommonRes response = await EventRepository().eventUpdateApiCall(
          address: addressController.text.trim(),
          categoryID: selectedCategory!.id,
          coverImage: base64ImageCover,
          date: eventDateController.text.trim(),
          description: descriptionController.text.trim(),
          disclaimer: disclaimerController.text.trim(),
          endTime: "${DateFormat('HH:mm').format(endTime)}:00",
          image: base64Image,
          latitude: latitudeController.text.trim(),
          longitude: longitudeController.text.trim(),
          placeName: placeController.text.trim(),
          statTime: "${DateFormat('HH:mm').format(startTime)}:00",
          status: status,
          title: titleController.text.trim(),
          eventID: widget.data!.id);
      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Event updated successfully");
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
