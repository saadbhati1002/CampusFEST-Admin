class PaymentRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<PaymentData> payments = [];

  PaymentRes({responseCode, result, responseMsg, payments});

  PaymentRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['payments'] != null) {
      payments = <PaymentData>[];
      json['payments'].forEach((v) {
        payments.add(PaymentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (payments.isNotEmpty) {
      data['payments'] = payments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentData {
  String? id;
  String? title;
  String? subtitle;
  String? img;
  String? status;
  String? pShow;

  PaymentData({id, title, subtitle, img, status, pShow});

  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    img = json['img'];
    status = json['status'];
    pShow = json['p_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['img'] = img;
    data['status'] = status;
    data['p_show'] = pShow;
    return data;
  }
}
