import 'dart:async';
import 'dart:convert';

import 'package:event/api/Data_save.dart';
import 'package:event/api/repository/auth.dart';
import 'package:event/model/auth/login_model.dart';
import 'package:event/screens/agent_chat_screen/auth_service.dart';
import 'package:event/screens/auth/reset_password/reset_password_screen.dart';
import 'package:event/screens/dashboard/dashboard_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String? type;
  final Map? params;
  final String? verID;
  const VerificationScreen({super.key, this.params, this.type, this.verID});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  bool isLoading = false;
  bool resendOtp = false;
  String otpPin = " ";
  String? vID = "";

  Timer? _timer;
  int _start = 20;

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            resendOtp = true;
            timer.cancel();
          });
        } else {
          setState(() {});
          _start--;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    startTimer();
    vID = widget.verID;
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  Future<void> verifyOTP(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: widget.verID!, smsCode: otpController.text);
      signInWithPhoneAuthCredential(phoneAuthCredential);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      setState(() {
        isLoading = true;
      });
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        if (widget.type == "Reset") {
          Get.to(() => ResetPasswordScreen(number: widget.params!["mobile"]));
        } else {
          LoginRes response =
              await AuthRepository().userRegisterApiCall(params: widget.params);
          if (response.responseCode == "200") {
            await AppConstant.userDetailSaved(json.encode(response));
            AppConstant.userData = response.adminLogin;
            save("currency", response.currency);
            save("AdminLogin", jsonEncode(response.adminLogin));
            AuthService().singUpAndStore(
                email: response.adminLogin!.username!,
                uid: response.adminLogin!.id!,
                proPicPath: "null");
            AppConstant.showToastMessage(
                "Your account register registered successfully");
            Get.to(() => const DashBoardScreen());
          } else {
            AppConstant.showToastMessage(response.responseMsg);
          }
        }
      } else {
        AppConstant.showToastMessage("Auth Failed!");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: AppColors.appColor,
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Verification".tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy Medium',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We've send you the verification".tr,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Gilroy Medium',
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 400),
                          Text(
                            "code on ${widget.params!["mobile"] ?? ""}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'Gilroy Medium',
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                animatedBorders(),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                GestureDetector(
                  onTap: () {
                    verifyOTP(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.appColor,
                    ),
                    child: const Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontFamily: "Gilroy Bold"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                resendOtp
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              otpController.clear();
                              verifyPhone(widget.params!["mobile"]);
                            },
                            child: Text(
                              "Re-send OTP".tr,
                              style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontFamily: 'Gilroy Bold'),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Re-send code in ",
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 12,
                                  fontFamily: 'Gilroy Medium'),
                            ),
                            Text(
                              durationToString(_start).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  Widget animatedBorders() {
    return Container(
      color: AppColors.whiteColor,
      height: Get.height * 0.06,
      width: Get.width * 0.90,
      child: Pinput(
        length: 6,
        controller: otpController,
        onSubmitted: (val) {},
        // onSubmit: (val) {},
        onChanged: (val) {},

        showCursor: false,

        defaultPinTheme: PinTheme(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey, width: 2)),
        ),
        focusedPinTheme: defaultPinTheme.copyDecorationWith(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade200)),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration?.copyWith(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey)),
        ),
      ),
    );
  }

  Future<void> verifyPhone(String number) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$number',
        // timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {
          AppConstant.showToastMessage("Auth Completed!");
        },
        verificationFailed: (FirebaseAuthException e) {
          // ApiWrapper.showToastMessage("Auth Failed!");
        },
        codeSent: (String verificationId, int? resendToken) {
          AppConstant.showToastMessage("OTP Sent!");
          vID = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // ApiWrapper.showToastMessage("Timeout!");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
