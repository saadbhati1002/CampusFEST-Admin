import 'package:event/api/http_manager.dart';
import 'package:event/model/auth/login_model.dart';

class AuthNetwork {
  static const String loginUserUrl = 'e_admin_log.php';
  static Future<dynamic> loginUser(prams) async {
    final result = await httpManager.post(url: loginUserUrl, data: prams);

    LoginRes response = LoginRes.fromJson(result);
    return response;
  }
}
