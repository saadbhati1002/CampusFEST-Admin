import 'package:event/api/repository/ticket/ticket.dart';
import 'package:event/model/ticket/detail/ticket_detail_model.dart';
import 'package:event/model/ticket/ticket_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketDetailsScreen extends StatefulWidget {
  final TicketData? data;
  const TicketDetailsScreen({super.key, this.data});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  bool isLoading = false;
  TicketDetailData? ticketData;
  @override
  void initState() {
    _getTicketData();
    super.initState();
  }

  Future _getTicketData() async {
    try {
      setState(() {
        isLoading = true;
      });
      TicketDetailRes response = await TicketRepository()
          .getTicketDetailApiCall(
              ticketID: widget.data?.id, userID: widget.data?.userID);
      if (response.responseCode == "200") {
        ticketData = response.ticketData;
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
        title: widget.data?.eventName ?? "",
      ),
      body: isLoading
          ? const ShowProgressBar()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                            subtitle: ticketData?.ticketTitle ?? "",
                          ),

                          SizedBox(height: Get.height * 0.014),
                          ticketTextRow(
                            title: "Date and Hour".toLowerCase(),
                            subtitle: ticketData?.startTime ?? "",
                          ),

                          SizedBox(height: Get.height * 0.014),
                          ticketTextRow(
                              title: "Event Location",
                              subtitle: ticketData?.eventAddress),

                          SizedBox(height: Get.height * 0.014),

                          //! ------- User Details --------
                          ticketUserRow(
                            title: "Full Name",
                            subtitle: ticketData?.ticketUsername ?? "",
                          ),

                          SizedBox(height: Get.height * 0.014),

                          ticketData != null
                              ? Column(
                                  children: [
                                    ticketUserRow(
                                      title: "Phone",
                                      subtitle: ticketData?.ticketMobile ?? "",
                                    ),

                                    SizedBox(height: Get.height * 0.014),
                                    ticketUserRow(
                                      title: "Email",
                                      subtitle: ticketData?.ticketEmail ?? "",
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    // //! ------- Ticket Price  --------
                                    ticketUserRow(
                                        title: "Seats",
                                        subtitle:
                                            "${ticketData?.totalTicket}x ${ticketData?.ticketType}"),
                                    SizedBox(height: Get.height * 0.014),
                                    ticketUserRow(
                                        title: "Tax",
                                        subtitle: "₹ ${ticketData?.ticketTax}"),
                                    SizedBox(height: Get.height * 0.014),
                                    ticketData != null
                                        ? ticketData?.ticketWallAmt != "0"
                                            ? Column(
                                                children: [
                                                  ticketUserRow(
                                                      title: "Wallet",
                                                      subtitle:
                                                          "₹ ${ticketData?.ticketWallAmt}"),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.018),
                                                ],
                                              )
                                            : const SizedBox()
                                        : const SizedBox(),
                                    ticketData != null
                                        ? ticketData?.ticketTotalAmt != "0"
                                            ? Column(
                                                children: [
                                                  ticketUserRow(
                                                      title: "Total",
                                                      subtitle:
                                                          "₹ ${ticketData?.ticketTotalAmt}"),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.032),
                                                ],
                                              )
                                            : const SizedBox()
                                        : const SizedBox(),
                                    ticketData != null
                                        ? ticketData?.ticketTransactionId != "0"
                                            ? Column(
                                                children: [
                                                  ticketUserRow(
                                                      title: "Transaction ID",
                                                      subtitle: ticketData
                                                          ?.ticketTransactionId),
                                                  SizedBox(
                                                      height:
                                                          Get.height * 0.014),
                                                ],
                                              )
                                            : const SizedBox()
                                        : const SizedBox(),

                                    ticketUserRow(
                                        title: "Payment Methods",
                                        subtitle: ticketData?.ticketPMethod),
                                    SizedBox(height: Get.height * 0.014),
                                    ticketUserRow(
                                      title: "Status",
                                      subtitle: ticketData?.ticketStatus,
                                    ),

                                    SizedBox(height: Get.height * 0.014),
                                    ticketUserRow(
                                        title: "Ticket Id",
                                        subtitle: ticketData?.ticketId),
                                    SizedBox(height: Get.height * 0.014),
                                  ],
                                )
                              : const SizedBox(),

                          SizedBox(height: Get.height * 0.02),
                        ],
                      ),
                    ),
                  )
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
}
