import 'package:event/api/http_manager.dart';
import 'package:event/model/event/details/event_detail_model.dart';
import 'package:event/model/event/event_model.dart';

class EventNetwork {
  static const String eventListUrl = 'e_admin_get_events.php';
  static const String eventDetailUrl = 'e_admin_get_event.php?event_id=';
  static Future<dynamic> getEventList() async {
    final result = await httpManager.get(
      url: eventListUrl,
    );

    EventRes response = EventRes.fromJson(result);
    return response;
  }

  static Future<dynamic> getEventDetail(param) async {
    final result = await httpManager.get(
      url: "$eventDetailUrl$param",
    );
    EventDataRes response = EventDataRes.fromJson(result);
    return response;
  }
}