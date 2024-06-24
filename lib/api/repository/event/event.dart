import 'package:event/api/network/event/event.dart';

class EventRepository {
  Future<dynamic> getEventListApiCall() async {
    return await EventNetwork.getEventList();
  }

  Future<dynamic> getEvenDetailApiCall({String? eventID}) async {
    return await EventNetwork.getEventDetail(eventID);
  }

  Future<dynamic> eventDeleteApiCall({String? userID}) async {
    return await EventNetwork.eventDelete(userID);
  }
}
