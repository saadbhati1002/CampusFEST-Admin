import 'package:event/api/network/coupon/coupon.dart';

class CouponRepository {
  Future<dynamic> getCouponListApiCall() async {
    return await CouponNetwork.getCouponList();
  }

  Future<dynamic> couponDeleteApiCall({String? couponID}) async {
    return await CouponNetwork.couponDelete(couponID);
  }

  Future<dynamic> addCouponApiCall({
    int? status,
    String? title,
    String? subtitle,
    String? couponCode,
    String? img,
    String? expireData,
    String? description,
    String? couponAmount,
    String? miniumOrderAMount,
  }) async {
    final body = {
      "status": status,
      "title": title,
      "subtitle": subtitle,
      "c_title": couponCode,
      "img": img,
      "date": expireData,
      "description": description,
      "amount": couponAmount,
      "minium_amount": miniumOrderAMount
    };
    return await CouponNetwork.addCoupon(body);
  }

  Future<dynamic> updateCouponApiCall({
    int? status,
    String? title,
    String? subtitle,
    String? couponCode,
    String? img,
    String? expireData,
    String? description,
    String? couponAmount,
    String? miniumOrderAMount,
    String? couponID,
  }) async {
    final body = {
      "status": status,
      "ctitle": title,
      "subtitle": subtitle,
      "c_title": couponCode,
      "c_img": img,
      "cdate": expireData,
      "c_desc": description,
      "c_value": couponAmount,
      "min_amt": miniumOrderAMount
    };
    return await CouponNetwork.updateCoupon(body, couponID);
  }
}
