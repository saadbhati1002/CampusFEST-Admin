import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  static const String baseUrl = 'https://app.campusfest.co/eapi/';
  static const String notificationUrl = "https://fcm.googleapis.com/fcm/send";
  static const String firebaseKey =
      "**********************************************************";
  // static UserData? userData;
  static String bearerToken = "null";

  static userDetailSaved(String userDetail) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('userDetail', userDetail);
  }

  static Future getUserDetail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userDetail');
  }

  static showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.gradientColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
