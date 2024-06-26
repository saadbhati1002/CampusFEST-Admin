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

  Future<dynamic> eventAddApiCall(
      {String? categoryID,
      String? title,
      String? date,
      String? statTime,
      endTime,
      address,
      latitude,
      longitude,
      placeName,
      description,
      disclaimer,
      image,
      coverImage,
      int? status}) async {
    final prams = {
      "cid": categoryID,
      "title": title,
      "sdate": date,
      "stime": statTime,
      "etime": endTime,
      "latitude": longitude,
      "longtitude": latitude,
      "place_name": placeName,
      "address": address,
      "description": description,
      "disclaimer": disclaimer,
      "status": status,
      "img": image,
      "cover_img": coverImage
    };
    return await EventNetwork.eventAdd(prams);
  }

  Future<dynamic> eventUpdateApiCall(
      {String? categoryID,
      String? title,
      String? date,
      String? statTime,
      endTime,
      address,
      latitude,
      longitude,
      placeName,
      description,
      disclaimer,
      image,
      coverImage,
      int? status,
      String? eventID}) async {
    final prams = {
      "cid": categoryID,
      "title": title,
      "sdate": date,
      "stime": statTime,
      "etime": endTime,
      "latitude": longitude,
      "longtitude": latitude,
      "place_name": placeName,
      "address": address,
      "description": description,
      "disclaimer": disclaimer,
      "status": status,
      "img": image ?? "",
      "cover_img": coverImage ?? ''
    };
    return await EventNetwork.eventUpdate(prams, eventID);
  }
}
