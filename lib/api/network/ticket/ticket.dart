import 'package:event/api/http_manager.dart';
import 'package:event/model/ticket/ticket_model.dart';

class TicketNetwork {
  static const String ticketListUrl = 'e_admin_get_ticket.php';
  static Future<dynamic> getTicketList() async {
    final result = await httpManager.get(
      url: ticketListUrl,
    );
    TicketRes response = TicketRes.fromJson(result);
    return response;
  }
}
