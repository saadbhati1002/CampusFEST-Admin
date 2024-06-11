import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:event/home_page.dart';
import 'package:event/api/Api_werper.dart';
import 'package:event/api/Data_save.dart';
import 'package:event/api/confrigation.dart';
import 'package:event/model/ticket_info.dart';
import 'package:event/utils/Colors.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';

Map ticketData = {};

class TicketDetailPage extends StatefulWidget {
  final String? eID;
  final String? ticketData;
  const TicketDetailPage({Key? key, this.eID, this.ticketData})
      : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? capturedImage;
  bool isLoading = false;
  TicketInfo? ticketInfo;
  List<TicketInfo> tickets = [];
  var resultTicket;

  String jsonString = "";
  String datastore = "";
  String verify = "";
  String formattedDate = "";
  DateTime current_date = DateTime.now();
  bool tapped = false;

//!------------------------
  @override
  void initState() {
    try {
      var response = jsonDecode(qCodeResult);
      ticketData = response["TicketData"];

      isLoading = false;
      datastore = getData.read("currency");

      setState(() {
        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        formattedDate = formatter.format(now);
        print("+++++++++++++++++++++++++++++++$formattedDate");
      });

      super.initState();
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
      ApiWrapper.showToastMessage("Invalid QRcode");
      Get.back();
    }
  }

  blankResponse() {
    setState(() {
      if (ticketData == null && ticketData.isEmpty) {
        Get.back();
      } else {}
    });
  }

  Future<String> _loadChatsAsset() async {
    return await rootBundle.loadString(widget.ticketData ?? "");
  }

  Future<List<TicketInfo>> loadChats() async {
    String jsonString = await _loadChatsAsset();
    var massage = tickets;
    final messagesJson = json.decode(jsonString);
    for (var messageJson in messagesJson) {
      massage.add(TicketInfo.fromJson(messageJson));
    }
    return massage;
  }

  @override
  Widget build(BuildContext context) {
    blankResponse();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {});
    });
    // notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: tapped
              ? InkWell(
                  onTap: () {
                    setState(() {
                      tapped = tapped;
                      VerifyTicket();
                    });
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.appColor),
                    child: const Center(
                      child: Text(
                        "Verified",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 16,
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      tapped = !tapped;
                      VerifyTicket();
                    });
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.appColor),
                    child: const Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 16,
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                )),
      appBar: AppBar(
        leading: const BackButton(color: AppColors.whiteColor),
        elevation: 0,
        backgroundColor: AppColors.appColor,
        centerTitle: false,
        title: const Text(
          "E-Ticket",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              fontFamily: 'Gilroy Medium',
              color: AppColors.whiteColor),
        ),
      ),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Screenshot(
                controller: screenshotController,
                child: SingleChildScrollView(
                  child: !isLoading
                      ? Container(
                          color: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //! barcode add
                                SizedBox(height: Get.height * 0.014),
                                ticketTextRow(
                                    title: "Event",
                                    subtitle: ticketData["ticket_title"]),

                                SizedBox(height: Get.height * 0.014),
                                ticketTextRow(
                                    title: "Date and Hour".toLowerCase(),
                                    subtitle: ticketData["start_time"]),

                                SizedBox(height: Get.height * 0.014),
                                ticketTextRow(
                                    title: "Event Location",
                                    subtitle: ticketData["event_address"]),

                                SizedBox(height: Get.height * 0.014),
                                ticketTextRow(
                                    title: "Event organizer",
                                    subtitle:
                                        ticketData["event_address_title"]),
                                SizedBox(height: Get.height * 0.02),
                                //! ------- User Details --------
                                ticketUserRow(
                                    title: "Full Name",
                                    subtitle: ticketData["ticket_username"]),

                                SizedBox(height: Get.height * 0.014),

                                ticketData["total_ticket"] != null
                                    ? Column(
                                        children: [
                                          ticketUserRow(
                                              title: "Phone",
                                              subtitle:
                                                  ticketData["ticket_mobile"]),

                                          SizedBox(height: Get.height * 0.014),
                                          ticketUserRow(
                                              title: "Email",
                                              subtitle:
                                                  ticketData["ticket_email"]),
                                          SizedBox(height: Get.height * 0.02),
                                          // //! ------- Ticket Price  --------
                                          ticketUserRow(
                                              title: "Seats",
                                              subtitle:
                                                  "${ticketData["total_ticket"]}x ${ticketData["ticket_type"]}"),
                                          SizedBox(height: Get.height * 0.014),
                                          ticketUserRow(
                                              title: "Tax",
                                              subtitle:
                                                  "${datastore}${ticketData["ticket_tax"]}"),
                                          SizedBox(height: Get.height * 0.014),
                                          ticketData != null
                                              ? ticketData["ticket_wall_amt"] !=
                                                      "0"
                                                  ? Column(
                                                      children: [
                                                        ticketUserRow(
                                                            title: "Wallet",
                                                            subtitle:
                                                                "${datastore}${ticketData["ticket_wall_amt"]}"),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.018),
                                                      ],
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),
                                          ticketData != null
                                              ? ticketData[
                                                          "ticket_total_amt"] !=
                                                      "0"
                                                  ? Column(
                                                      children: [
                                                        ticketUserRow(
                                                            title: "Total",
                                                            subtitle:
                                                                "${datastore}${ticketData["ticket_total_amt"]}"),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.032),
                                                      ],
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),
                                          ticketData != null
                                              ? ticketData[
                                                          "ticket_transaction_id"] !=
                                                      "0"
                                                  ? Column(
                                                      children: [
                                                        ticketUserRow(
                                                            title:
                                                                "Transaction ID",
                                                            subtitle: ticketData[
                                                                "ticket_transaction_id"]),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.014),
                                                      ],
                                                    )
                                                  : const SizedBox()
                                              : const SizedBox(),

                                          ticketUserRow(
                                              title: "Payment Methods",
                                              subtitle: ticketData[
                                                  "ticket_p_method"]),
                                          SizedBox(height: Get.height * 0.014),
                                          ticketUserRow(
                                              title: "Status",
                                              subtitle:
                                                  ticketData["ticket_status"]),
                                          SizedBox(height: Get.height * 0.02),
                                          ticketUserRow(
                                              title: "Uid",
                                              subtitle: ticketData["uid"]),
                                          SizedBox(height: Get.height * 0.014),
                                          ticketUserRow(
                                              title: "Ticket Id",
                                              subtitle:
                                                  ticketData["ticket_id"]),
                                          SizedBox(height: Get.height * 0.014),
                                        ],
                                      )
                                    : const SizedBox(),
                                ticketUserRow(
                                    title: "Current Date",
                                    subtitle: formattedDate),
                                SizedBox(height: Get.height * 0.02),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                )),
          ],
        ),
      ),
    );
  }

  ticketUserRow({String? title, subtitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? "",
            style: const TextStyle(
                fontSize: 14, fontFamily: 'Gilroy Medium', color: Colors.grey)),
        Ink(
          width: Get.width * 0.50,
          child: Text(
            subtitle ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  ticketUserCopy(
      {String? title, subtitle, Widget? textCopy, Function()? OnTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Tooltip(
          preferBelow: false,
          message: "Copy",
          child: Text(title!,
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Gilroy Medium',
                  color: Colors.grey)),
        ),
        InkWell(
          onTap: OnTap,
          child: Row(
            children: [
              Ink(
                width: Get.width * 0.50,
                child: Text(subtitle ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Gilroy Medium',
                        color: AppColors.blackColor)),
              ),
              SizedBox(child: textCopy)
            ],
          ),
        )
      ],
    );
  }

  ticketTextRow({String? title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!,
            style: const TextStyle(
                fontSize: 14, fontFamily: 'Gilroy Medium', color: Colors.grey)),
        SizedBox(height: Get.height * 0.006),
        Text(subtitle ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: AppColors.blackColor,
            )),
      ],
    );
  }

  VerifyTicket() async {
    try {
      Map map = {
        "uid": ticketData["uid"],
        "tic_id": ticketData["ticket_id"],
        "ve_date": formattedDate
      };
      print("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
          "${ticketData["uid"]}--------------${ticketData["ticket_id"]}++++++++++++++++++${formattedDate}");
      Uri uri = Uri.parse(AppUrl.verify);
      var response = await http.post(uri, body: jsonEncode(map));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        verify = result["Result"];
        print("*********************${verify}");

        if (verify == "true") {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
