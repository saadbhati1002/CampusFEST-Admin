class LoginRes {
  UserData? adminLogin;
  String? currency;
  String? responseCode;
  String? result;
  String? responseMsg;

  LoginRes({adminLogin, currency, responseCode, result, responseMsg});

  LoginRes.fromJson(Map<String, dynamic> json) {
    adminLogin = json['AdminLogin'] != null
        ? UserData.fromJson(json['AdminLogin'])
        : null;
    currency = json['currency'];
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (adminLogin != null) {
      data['AdminLogin'] = adminLogin!.toJson();
    }
    data['currency'] = currency;
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    return data;
  }
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? countryCode;
  String? password;
  String? createdDate;
  String? proPic;
  String? status;

  UserData(
      {id,
      username,
      email,
      mobile,
      countryCode,
      password,
      createdDate,
      proPic,
      status});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    countryCode = json['ccode'];
    password = json['password'];
    createdDate = json['rdate'];
    proPic = json['pro_pic'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['ccode'] = countryCode;
    data['password'] = password;
    data['rdate'] = createdDate;
    data['pro_pic'] = proPic;
    data['status'] = status;
    return data;
  }
}
