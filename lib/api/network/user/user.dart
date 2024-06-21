import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/user/user_model.dart';

class UserNetwork {
  static const String userListUrl = 'e_admin_get_users.php';
  static const String userStatusChangeUrl = 'e_acc_status_change.php';
  static const String userAccountDeleteUrl =
      'e_user_account_delete.php?user_id=';
  static Future<dynamic> getUserList() async {
    final result = await httpManager.get(
      url: userListUrl,
    );
    UserRes response = UserRes.fromJson(result);
    return response;
  }

  static Future<dynamic> userStatusChange(params) async {
    final result =
        await httpManager.post(url: userStatusChangeUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> userAccountDelete(params) async {
    print(params);
    final result =
        await httpManager.deleteWithToken(url: "$userAccountDeleteUrl$params");
    print(result);
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
