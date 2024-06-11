import 'package:event/api/network/auth/auth.dart';

class AuthRepository {
  Future<dynamic> userLoginApiCall({String? email, String? password}) async {
    final params = {"email": email, "password": password};
    return await AuthNetwork.loginUser(params);
  }
}
