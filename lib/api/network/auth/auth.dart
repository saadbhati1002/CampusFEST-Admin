import 'package:event/api/http_manager.dart';
import 'package:event/model/auth/login_model.dart';
import 'package:event/model/common/common_model.dart';

class AuthNetwork {
  static const String loginUserUrl = 'e_admin_log.php';
  static const String mobileEmailCheckUrl = 'e_admin_mobile_email_check.php';
  static const String mobileCheckUrl = '/e_admin_mobile_check.php';
  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUserUrl, data: prams);
    LoginRes response = LoginRes.fromJson(result);
    return response;
  }

  static Future<dynamic> mobileEmailCheck(prams) async {
    final result =
        await httpManager.post(url: mobileEmailCheckUrl, data: prams);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> mobileCheck(prams) async {
    final result = await httpManager.post(url: mobileCheckUrl, data: prams);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
