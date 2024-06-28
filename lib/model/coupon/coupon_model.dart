class CouponRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<CouponData> coupons = [];

  CouponRes({responseCode, result, responseMsg, coupons});

  CouponRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['coupons'] != null) {
      coupons = <CouponData>[];
      json['coupons'].forEach((v) {
        coupons.add(CouponData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (coupons.isNotEmpty) {
      data['coupons'] = coupons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponData {
  String? id;
  String? title;
  String? subtitle;
  String? coupon;
  String? img;
  String? endDate;
  String? description;
  String? couponAmount;
  String? miniumAmount;
  String? status;

  CouponData(
      {id,
      title,
      subtitle,
      coupon,
      img,
      endDate,
      description,
      couponAmount,
      miniumAmount,
      status});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    coupon = json['coupon'];
    img = json['img'];
    endDate = json['end_date'];
    description = json['description'];
    couponAmount = json['coupon_amount'];
    miniumAmount = json['minium_amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['coupon'] = coupon;
    data['img'] = img;
    data['end_date'] = endDate;
    data['description'] = description;
    data['coupon_amount'] = couponAmount;
    data['minium_amount'] = miniumAmount;
    data['status'] = status;
    return data;
  }
}
