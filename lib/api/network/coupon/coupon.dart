import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/coupon/coupon_model.dart';

class CouponNetwork {
  static const String couponListUrl = 'e_admin_get_coupons.php';
  static const String couponDeleteUrl = 'e_admin_delete_coupon.php?coupon_id=';
  static const String addCouponUrl = 'e_admin_add_coupon.php';
  static const String updateCouponUrl = 'e_admin_update_coupon.php?coupon_id=';

  static Future<dynamic> getCouponList() async {
    final result = await httpManager.get(
      url: couponListUrl,
    );

    CouponRes response = CouponRes.fromJson(result);
    return response;
  }

  static Future<dynamic> couponDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$couponDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addCoupon(params) async {
    final result = await httpManager.post(url: addCouponUrl, data: params);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateCoupon(params, couponID) async {
    final result =
        await httpManager.put(url: "$updateCouponUrl$couponID", data: params);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
