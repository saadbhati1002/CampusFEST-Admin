class EventRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<EventData> events = [];

  EventRes({responseCode, result, responseMsg, events});

  EventRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['events'] != null) {
      events = <EventData>[];
      json['events'].forEach((v) {
        events.add(EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (events.isNotEmpty) {
      data['events'] = events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
  String? id;
  String? title;
  String? eventData;
  String? img;
  String? coverImg;
  String? address;
  String? status;
  String? eventStatus;
  String? eventTime;
  String? totalTickets;
  String? startTime;
  String? endTime;
  String? latitude;
  String? longitude;
  String? eventPlace;
  String? description;
  String? disclaimer;
  String? catID;

  EventData(
      {id,
      title,
      eventData,
      img,
      coverImg,
      address,
      status,
      eventStatus,
      eventTime,
      totalTickets,
      startTime,
      endTime,
      latitude,
      longitude,
      catID,
      disclaimer,
      description,
      eventPlace});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    eventData = json['sdate'];
    img = json['img'];
    coverImg = json['cover_img'];
    address = json['address'];
    status = json['status'];
    eventStatus = json['event_status'];
    eventTime = json['event_time'];
    totalTickets = json['total_tickets'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    eventPlace = json['place_name'];
    catID = json['cid'];
    description = json['description'];
    disclaimer = json['disclaimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sdate'] = eventData;
    data['img'] = img;
    data['cover_img'] = coverImg;
    data['address'] = address;
    data['status'] = status;
    data['event_status'] = eventStatus;
    data['event_time'] = eventTime;
    data['total_tickets'] = totalTickets;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
