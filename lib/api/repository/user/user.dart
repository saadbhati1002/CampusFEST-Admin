import 'package:event/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> getUserListApiCall() async {
    return await UserNetwork.getUserList();
  }

  Future<dynamic> userStatusChangeApiCall({String? userID, int? status}) async {
    final params = {"uid": userID, "status": status};
    return await UserNetwork.userStatusChange(params);
  }
}
