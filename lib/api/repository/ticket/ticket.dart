import 'package:event/api/network/ticket/ticket.dart';

class TicketRepository {
  Future<dynamic> getTicketListApiCall() async {
    return await TicketNetwork.getTicketList();
  }
}
