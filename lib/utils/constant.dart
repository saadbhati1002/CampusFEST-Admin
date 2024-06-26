import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event/model/auth/login_model.dart';

class AppConstant {
  static const String baseUrl = 'https://app.campusfest.co/eapi/';
  static const String imageUrl = 'https://app.campusfest.co/';
  static const String notificationUrl = "https://fcm.googleapis.com/fcm/send";
  static LatLng locationLatLong = const LatLng(28.7041, 77.1025);
  static String googleMapApiKey = "AIzaSyDcr5WtDuAsJS2aZRe-5OTD39sZ6iUrHYk";

  static String currentAddress = "";
  static const String firebaseKey =
      "**********************************************************";
  static UserData? userData;
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

  static var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'PHPSESSID=oonu3ro0agbeiik4t0l6egt8ab',
    "uid": AppConstant.userData != null ? AppConstant.userData!.id! : "",
  };
}
