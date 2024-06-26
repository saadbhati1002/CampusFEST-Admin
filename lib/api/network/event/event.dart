import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/event/details/event_detail_model.dart';
import 'package:event/model/event/event_model.dart';

class EventNetwork {
  static const String eventListUrl = 'e_admin_get_events.php';
  static const String eventDetailUrl = 'e_admin_get_event.php?event_id=';
  static const String eventDeleteUrl = 'e_admin_event_delete.php?event_id=';
  static const String eventAddUrl = 'e_admin_add_event.php';
  static const String eventUpdateUrl = 'e_admin_update_event.php?event_id=';
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

  static Future<dynamic> eventDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$eventDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> eventAdd(params) async {
    final result = await httpManager.post(url: eventAddUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> eventUpdate(params, eventID) async {
    print(params);
    final result =
        await httpManager.put(url: "$eventUpdateUrl$eventID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
