import 'package:event/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> getUserListApiCall() async {
    return await UserNetwork.getUserList();
  }

  Future<dynamic> userStatusChangeApiCall({String? userID, int? status}) async {
    final params = {"uid": userID, "status": status};
    return await UserNetwork.userStatusChange(params);
  }

  Future<dynamic> userAccountDeleteApiCall({String? userID}) async {
    return await UserNetwork.userAccountDelete(userID);
  }

  Future<dynamic> getAdminListApiCall() async {
    return await UserNetwork.getAdminList();
  }

  Future<dynamic> adminStatusChangeApiCall(
      {String? userID, int? status}) async {
    final params = {"uid": userID, "status": status};
    return await UserNetwork.adminStatusChange(params);
  }
}
