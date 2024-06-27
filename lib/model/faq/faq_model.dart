class FaqRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<FaqData> faq = [];

  FaqRes({responseCode, result, responseMsg, faq});

  FaqRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['faq'] != null) {
      faq = <FaqData>[];
      json['faq'].forEach((v) {
        faq.add(FaqData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (faq.isNotEmpty) {
      data['faq'] = faq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqData {
  String? id;
  String? question;
  String? answer;
  String? status;
  String? catID;

  FaqData({id, question, answer, status, catID});

  FaqData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    catID = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['status'] = status;
    data['cat_id'] = catID;
    return data;
  }
}
