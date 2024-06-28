import 'package:event/api/repository/ticket/ticket.dart';
import 'package:event/model/ticket/ticket_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:flutter/material.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  List<TicketData> ticketList = [];
  bool isLoading = false;
  Future<bool> _onBackPress() async {
    Navigator.pop(context, ticketList.length);
    return false;
  }

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
      TicketRes response = await TicketRepository().getTicketListApiCall();
      if (response.tickets.isNotEmpty) {
        ticketList = response.tickets;
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
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: titleAppBar(
          onTap: () {
            Navigator.pop(context, ticketList.length);
          },
          title: "Tickets ",
        ),
        body: !isLoading
            ? ListView.builder(
                itemCount: ticketList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemBuilder: (context, index) {
                  return ticketWidget(data: ticketList[index], index: index);
                },
              )
            : ListView.builder(
                itemCount: 10,
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                itemBuilder: (context, index) {
                  return const CommonSkeleton();
                },
              ),
      ),
    );
  }

  Widget ticketWidget({TicketData? data, int? index}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data?.eventName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'User: ${data?.userName}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Total Tickets: ${data?.totalTicket}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Total Amount: ${data?.price}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Status: ${data?.ticketType}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
