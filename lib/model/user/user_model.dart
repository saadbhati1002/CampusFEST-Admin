class UserRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<UserData> users = [];

  UserRes({responseCode, result, responseMsg, users});

  UserRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['users'] != null) {
      users = <UserData>[];
      json['users'].forEach((v) {
        users.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (users.isNotEmpty) {
      data['users'] = users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? rDate;
  String? cCode;
  String? wallet;
  String? proPic;
  String? status;

  UserData({id, name, email, mobile, rDate, cCode, wallet, proPic, status});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    rDate = json['rdate'];
    cCode = json['ccode'];
    wallet = json['wallet'];
    proPic = json['pro_pic'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['rdate'] = rDate;
    data['ccode'] = cCode;
    data['wallet'] = wallet;
    data['pro_pic'] = proPic;
    data['status'] = status;
    return data;
  }
}
