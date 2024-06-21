import 'package:event/api/http_manager.dart';
import 'package:event/model/user/user_model.dart';

class UserNetwork {
  static const String userListUrl = 'e_admin_get_users.php';
  static Future<dynamic> getUserList() async {
    final result = await httpManager.get(
      url: userListUrl,
    );
    UserRes response = UserRes.fromJson(result);
    return response;
  }
}
