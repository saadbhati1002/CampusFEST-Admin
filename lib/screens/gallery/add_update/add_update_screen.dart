import 'dart:convert';
import 'dart:io';
import 'package:event/api/repository/event/event.dart';
import 'package:event/api/repository/gallery/gallery.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/event/event_model.dart';
import 'package:event/model/gallery/gallery_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddGalleryScreen extends StatefulWidget {
  final bool? isFromAdd;
  final GalleryData? data;
  const AddGalleryScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddGalleryScreen> createState() => _AddGalleryScreenState();
}

class _AddGalleryScreenState extends State<AddGalleryScreen> {
  List<EventData> eventList = [];

  File? galleryImage;
  bool isLoading = false;
  String? galleryStatus;
  EventData? selectedEvent;
  @override
  void initState() {
    _checkData();
    _getEventData();
    super.initState();
  }

  Future _getEventData() async {
    try {
      setState(() {
        isLoading = true;
      });
      EventRes response = await EventRepository().getEventListApiCall();
      if (response.events.isNotEmpty) {
        eventList = response.events;
        if (widget.isFromAdd == false) {
          for (int i = 0; i < eventList.length; i++) {
            if (eventList[i].id == widget.data!.id) {
              selectedEvent = eventList[i];
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

    if (widget.data!.status != null && widget.data!.status != null) {
      galleryStatus = widget.data!.status;
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
        title: "Add Gallery Image",
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
                          items: eventList.map((EventData value) {
                            return DropdownMenuItem<EventData>(
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
                            selectedEvent?.title ?? "Select Event",
                            maxLines: 1,
                            style: TextStyle(
                              color: selectedEvent == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: selectedEvent == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            selectedEvent = value;
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
                            galleryStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: galleryStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: galleryStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            galleryStatus = value;
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
                    imageFile: galleryImage,
                    index: 1,
                    title: 'Gallery Image',
                    imagePath: widget.data?.img ?? ''),
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
        galleryImage = File(image.path);
      } else if (index == 2) {}
      setState(() {});
    }
  }

  Future _addCategory() async {
    if (selectedEvent == null) {
      AppConstant.showToastMessage("Please select event");
      return;
    }
    if (galleryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    if (galleryImage == null) {
      AppConstant.showToastMessage("Please select image");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      int status = galleryStatus == "Publish" ? 1 : 0;
      List<int> imageBytes = galleryImage!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      CommonRes response = await GalleryRepository().addGalleryApiCall(
          status: status, eventID: selectedEvent!.id, img: base64Image);

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Gallery image added successfully");
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
    if (selectedEvent == null) {
      AppConstant.showToastMessage("Please select event");
      return;
    }
    if (galleryStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }
    String? base64Image;
    int status = galleryStatus == "Publish" ? 1 : 0;

    if (galleryImage != null) {
      List<int> imageBytes = galleryImage!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    }
    CommonRes response = await GalleryRepository().updateGalleryApiCall(
      status: status,
      eventID: selectedEvent!.id,
      img: base64Image,
      galleryID: widget.data!.id,
    );

    if (response.responseCode == "200") {
      AppConstant.showToastMessage("Gallery image updated successfully");
      Navigator.pop(context, 1);
    } else {
      AppConstant.showToastMessage("Getting some error please try again");
    }
    try {
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
