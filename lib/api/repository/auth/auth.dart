import 'package:event/api/network/auth/auth.dart';

class AuthRepository {
  Future<dynamic> userLoginApiCall({String? email, String? password}) async {
    final params = {"email": email, "password": password};
    return await AuthNetwork.loginUser(params);
  }

  Future<dynamic> userRegisterApiCall({Map? params}) async {
    return await AuthNetwork.registerUser(params);
  }

  Future<dynamic> mobileEmailCheckApiCall(
      {String? email, String? mobile}) async {
    final params = {"mobile": mobile, "email": email};
    return await AuthNetwork.mobileEmailCheck(params);
  }

  Future<dynamic> mobileCheckApiCall({String? mobile}) async {
    final params = {
      "mobile": mobile,
    };
    return await AuthNetwork.mobileCheck(params);
  }

  Future<dynamic> resetPasswordApiCall(
      {String? mobile, String? password}) async {
    final params = {"mobile": mobile, "password": password};
    return await AuthNetwork.resetPassword(params);
  }
}
