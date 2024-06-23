class EventDataRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  Event? event;

  EventDataRes({responseCode, result, responseMsg, event});

  EventDataRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    event = json['event'] != null ? Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class Event {
  String? id;
  String? title;
  String? img;
  String? coverImg;
  String? eventData;
  String? stime;
  String? eventTime;
  String? latitude;
  String? longitudes;
  String? placeName;
  String? status;
  String? address;
  String? cid;
  String? description;
  String? disclaimer;

  Event(
      {id,
      title,
      img,
      coverImg,
      eventData,
      stime,
      eventTime,
      latitude,
      longitudes,
      placeName,
      status,
      address,
      cid,
      description,
      disclaimer});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    coverImg = json['cover_img'];
    eventData = json['sdate'];
    stime = json['stime'];
    eventTime = json['etime'];
    latitude = json['latitude'];
    longitudes = json['longtitude'];
    placeName = json['place_name'];
    status = json['status'];
    address = json['adress'];
    cid = json['cid'];
    description = json['description'];
    disclaimer = json['disclaimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img'] = img;
    data['cover_img'] = coverImg;
    data['sdate'] = eventData;
    data['stime'] = stime;
    data['etime'] = eventTime;
    data['latitude'] = latitude;
    data['longtitude'] = longitudes;
    data['place_name'] = placeName;
    data['status'] = status;
    data['adress'] = address;
    data['cid'] = cid;
    data['description'] = description;
    data['disclaimer'] = disclaimer;
    return data;
  }
}
