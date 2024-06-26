class FaqCategoryRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<FaqCategoryData> categories = [];

  FaqCategoryRes({responseCode, result, responseMsg, categories});

  FaqCategoryRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['categories'] != null) {
      categories = <FaqCategoryData>[];
      json['categories'].forEach((v) {
        categories.add(FaqCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (categories.isNotEmpty) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqCategoryData {
  String? id;
  String? title;
  String? status;

  FaqCategoryData({id, title, status});

  FaqCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    return data;
  }
}
