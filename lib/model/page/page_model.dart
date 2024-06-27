class PageRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<PagesData> pages = [];

  PageRes({responseCode, result, responseMsg, pages});

  PageRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['pages'] != null) {
      pages = <PagesData>[];
      json['pages'].forEach((v) {
        pages.add(PagesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (pages.isNotEmpty) {
      data['pages'] = pages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PagesData {
  String? id;
  String? title;
  String? description;
  String? status;

  PagesData({id, title, description, status});

  PagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
