import 'package:event/api/repository/price_type/price_type.dart';
import 'package:event/model/price_type/price_type_model.dart';
import 'package:flutter/material.dart';
import 'package:event/api/repository/event/event.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/event/event_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';

class AddTypePriceScreen extends StatefulWidget {
  final bool? isFromAdd;
  final PriceTypeData? data;
  const AddTypePriceScreen({super.key, this.data, this.isFromAdd});

  @override
  State<AddTypePriceScreen> createState() => _AddTypePriceScreenState();
}

class _AddTypePriceScreenState extends State<AddTypePriceScreen> {
  List<EventData> eventList = [];
  TextEditingController eventTypeController = TextEditingController();
  TextEditingController eventTicketPriceController = TextEditingController();
  TextEditingController eventTicketLimitController = TextEditingController();
  bool isLoading = false;
  EventData? selectedEvent;
  String? sponsorStatus;
  @override
  void initState() {
    _checkData();
    _getEventData();
    super.initState();
  }

  Future _checkData() async {
    if (widget.isFromAdd == true) {
      return;
    }
    if (widget.data!.type != null && widget.data!.type != "") {
      eventTypeController.text = widget.data!.type!;
    }
    if (widget.data!.price != null && widget.data!.price != "") {
      eventTicketPriceController.text = widget.data!.price!;
    }
    if (widget.data!.ticketLimit != null && widget.data!.ticketLimit != "") {
      eventTicketLimitController.text = widget.data!.ticketLimit!;
    }
    if (widget.data!.status != null && widget.data!.status != null) {
      sponsorStatus = widget.data!.status;
    }
    setState(() {});
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
            if (eventList[i].id == widget.data!.eventID) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: titleAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Add Type & Price",
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
                  child: textfield(
                    controller: eventTypeController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Event Type",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    keyboardType: TextInputType.number,
                    controller: eventTicketPriceController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Event Ticket Price",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: textfield(
                    keyboardType: TextInputType.number,
                    controller: eventTicketLimitController,
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    text: "Event Ticket Limit",
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
                            sponsorStatus ?? "Status",
                            maxLines: 1,
                            style: TextStyle(
                              color: sponsorStatus == null
                                  ? AppColors.greyColor
                                  : AppColors.textColor,
                              fontSize: 16,
                              fontWeight: sponsorStatus == null
                                  ? FontWeight.w400
                                  : FontWeight.w500,
                            ),
                          ),
                          onChanged: (value) {
                            sponsorStatus = value;
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
                        _addPriceType();
                      } else {
                        _updatePriceType();
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

  Future _addPriceType() async {
    if (selectedEvent == null) {
      AppConstant.showToastMessage("Please select event");
      return;
    }
    if (eventTypeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter event type");
      return;
    }
    if (eventTicketPriceController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter ticket price");
      return;
    }
    if (eventTicketLimitController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter limit");
      return;
    }
    if (sponsorStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      int status = sponsorStatus == "Publish" ? 1 : 0;

      CommonRes response = await PriceTypeRepository().addPriceTypeApiCall(
        status: status,
        eventID: selectedEvent!.id,
        limit: eventTicketLimitController.text.trim(),
        price: eventTicketPriceController.text.trim(),
        type: eventTypeController.text.trim(),
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Type & Price added successfully");
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

  Future _updatePriceType() async {
    if (selectedEvent == null) {
      AppConstant.showToastMessage("Please select event");
      return;
    }
    if (eventTypeController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter event type");
      return;
    }
    if (eventTicketPriceController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter ticket price");
      return;
    }
    if (eventTicketLimitController.text.isEmpty) {
      AppConstant.showToastMessage("Please enter limit");
      return;
    }
    if (sponsorStatus == null) {
      AppConstant.showToastMessage("Please select status");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      int status = sponsorStatus == "Publish" ? 1 : 0;

      CommonRes response = await PriceTypeRepository().updatePriceTypeApiCall(
        status: status,
        eventID: selectedEvent!.id,
        limit: eventTicketLimitController.text.trim(),
        price: eventTicketPriceController.text.trim(),
        type: eventTypeController.text.trim(),
        priceTypeID: widget.data!.id,
        // title: titleController.text.toString(),
      );

      if (response.responseCode == "200") {
        AppConstant.showToastMessage("Type & Price updated successfully");
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
