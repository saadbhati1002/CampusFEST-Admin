import 'package:event/api/http_manager.dart';
import 'package:event/model/ticket/detail/ticket_detail_model.dart';
import 'package:event/model/ticket/ticket_model.dart';

class TicketNetwork {
  static const String ticketListUrl = 'e_admin_get_ticket.php';
  static const String ticketDetailUrl = 'e_ticket_data.php';
  static Future<dynamic> getTicketList() async {
    final result = await httpManager.get(
      url: ticketListUrl,
    );
    TicketRes response = TicketRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getTicketDetail(param) async {
    print(param);
    final result = await httpManager.post(url: ticketDetailUrl, data: param);
    print(result);
    TicketDetailRes response = TicketDetailRes.fromJson(result);
    return response;
  }
}
