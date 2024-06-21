import 'package:event/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> getUserListApiCall() async {
    return await UserNetwork.getUserList();
  }
}
