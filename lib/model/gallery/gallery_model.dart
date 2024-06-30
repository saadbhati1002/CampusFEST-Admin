class GalleryRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<GalleryData> gallery = [];

  GalleryRes({responseCode, result, responseMsg, gallery});

  GalleryRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['gallery'] != null) {
      gallery = <GalleryData>[];
      json['gallery'].forEach((v) {
        gallery.add(GalleryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (gallery.isNotEmpty) {
      data['gallery'] = gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryData {
  String? id;
  String? eventName;
  String? eventID;
  String? img;
  String? status;

  GalleryData({eventName, img, status, id});

  GalleryData.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    img = json['img'];
    status = json['status'];
    id = json['id'];
    eventID = json['event_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_name'] = eventName;
    data['img'] = img;
    data['status'] = status;
    data['id'] = id;
    return data;
  }
}
