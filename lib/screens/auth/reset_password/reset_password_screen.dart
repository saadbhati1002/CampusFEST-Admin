import 'package:event/api/repository/auth.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/screens/auth/login/login.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? number;
  const ResetPasswordScreen({super.key, this.number});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  bool _obscureText1 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
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
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
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
                          const Text(
                            "Please enter your new password",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Gilroy Medium',
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 400),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: textfield(
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    text: "Password",
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    prefix: Image.asset(
                      "assets/Lock.png",
                      scale: 3.5,
                      color: AppColors.textColor,
                    ),
                    obstacle: _obscureText,
                    suffix: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: !_obscureText
                          ? const Icon(Icons.visibility,
                              color: AppColors.darkblue)
                          : const Icon(Icons.visibility_off,
                              color: AppColors.greyColor),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: textfield(
                    controller: confirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Confirm Password';
                      }
                      return null;
                    },
                    text: "Confirm password",
                    fieldColor: AppColors.bgColor,
                    labelColor: AppColors.greyColor,
                    prefix: Image.asset(
                      "assets/Lock.png",
                      scale: 3.5,
                      color: AppColors.textColor,
                    ),
                    obstacle: _obscureText1,
                    suffix: GestureDetector(
                      onTap: () {
                        _toggle2();
                      },
                      child: !_obscureText1
                          ? const Icon(Icons.visibility,
                              color: AppColors.darkblue)
                          : const Icon(Icons.visibility_off,
                              color: AppColors.greyColor),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                GestureDetector(
                  onTap: () {
                    _resetPassword();
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
                        "RESET",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontFamily: "Gilroy Bold"),
                      ),
                    ),
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

  Future _resetPassword() async {
    if (password.text.isEmpty) {
      AppConstant.showToastMessage("Please Enter Your Password");
      return;
    }
    if (confirmPassword.text.isEmpty) {
      AppConstant.showToastMessage("Please Enter Your Confirm Password");
      return;
    }
    if (password.text.trim() != confirmPassword.text.trim()) {
      AppConstant.showToastMessage(
          "Your Password Not Match With Confirm Password");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response = await AuthRepository().resetPasswordApiCall(
        mobile: widget.number,
        password: password.text.trim(),
      );
      if (response.responseCode == "200") {
        AppConstant.showToastMessage(response.responseMsg);
        Get.to(() => const LoginScreen());
      } else {
        AppConstant.showToastMessage(response.responseMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
