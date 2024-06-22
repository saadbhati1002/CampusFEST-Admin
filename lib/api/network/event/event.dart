import 'package:event/api/http_manager.dart';
import 'package:event/model/event/event_model.dart';

class EventNetwork {
  static const String eventListUrl = 'e_admin_get_events.php';
  static Future<dynamic> getEventList() async {
    final result = await httpManager.get(
      url: eventListUrl,
    );
    print(result);
    EventRes response = EventRes.fromJson(result);
    return response;
  }
}
