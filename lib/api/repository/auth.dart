import 'package:event/api/network/auth/auth.dart';

class AuthRepository {
  Future<dynamic> userLoginApiCall({String? email, String? password}) async {
    final params = {"email": email, "password": password};
    return await AuthNetwork.loginUser(params);
  }

  Future<dynamic> mobileEmailCheckApiCall(
      {String? email, String? mobile}) async {
    final params = {"mobile": mobile, "email": email};
    return await AuthNetwork.mobileEmailCheck(params);
  }
}
