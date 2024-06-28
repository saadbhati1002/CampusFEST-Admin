import 'package:event/api/network/ticket/ticket.dart';

class TicketRepository {
  Future<dynamic> getTicketListApiCall() async {
    return await TicketNetwork.getTicketList();
  }

  Future<dynamic> getTicketDetailApiCall(
      {String? ticketID, String? userID}) async {
    final param = {
      "uid": userID,
      "tid": ticketID,
    };
    return await TicketNetwork.getTicketDetail(param);
  }
}
