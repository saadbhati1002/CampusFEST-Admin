class SponsorRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<SponsorData> sponsors = [];

  SponsorRes({responseCode, result, responseMsg, sponsors});

  SponsorRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['sponsors'] != null) {
      sponsors = <SponsorData>[];
      json['sponsors'].forEach((v) {
        sponsors.add(SponsorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (sponsors.isEmpty) {
      data['sponsors'] = sponsors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SponsorData {
  String? id;
  String? eventName;
  String? title;
  String? img;
  String? status;

  SponsorData({id, eventName, title, img, status});

  SponsorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    title = json['title'];
    img = json['img'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_name'] = eventName;
    data['title'] = title;
    data['img'] = img;
    data['status'] = status;
    return data;
  }
}
