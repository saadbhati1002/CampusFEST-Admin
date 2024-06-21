class CategoryRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<CategoryData> categories = [];

  CategoryRes({responseCode, result, responseMsg, categories});

  CategoryRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['categories'] != null) {
      categories = <CategoryData>[];
      json['categories'].forEach((v) {
        categories.add(CategoryData.fromJson(v));
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

class CategoryData {
  String? id;
  String? title;
  String? img;
  String? coverImg;
  String? status;

  CategoryData({id, title, img, coverImg, status});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    coverImg = json['cover_img'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img'] = img;
    data['cover_img'] = coverImg;
    data['status'] = status;
    return data;
  }
}
