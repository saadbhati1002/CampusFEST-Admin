// ignore_for_file: prefer_final_fields, body_might_complete_normally_nullable, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, deprecated_member_use, avoid_print

import 'package:event/api/repository/auth.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/screens/auth/login/login.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool status = false;
  final auth = FirebaseAuth.instance;

  final name = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referral = TextEditingController();
  bool isLoading = false;
  String? _selectedCountryCode = '+91';

  bool _obscureText = true;
  bool obscureText_ = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void toggle() {
    setState(() {
      obscureText_ = !obscureText_;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sign up".tr,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy Medium',
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      textfield(
                        controller: name,
                        text: "Name",
                        keyboardType: TextInputType.name,
                        fieldColor: AppColors.bgColor,
                        labelColor: AppColors.greyColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                        prefix: Image.asset(
                          "assets/Profile.png",
                          scale: 3.5,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .02),
                      textfield(
                        controller: email,
                        text: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                        fieldColor: AppColors.bgColor,
                        labelColor: AppColors.greyColor,
                        prefix: Image.asset(
                          "assets/Message.png",
                          scale: 3.5,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .02),
                      Ink(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 12),
                                  Image.asset(
                                    "assets/Call1.png",
                                    scale: 3.5,
                                    color: AppColors.textColor,
                                  ),
                                  Text(
                                    _selectedCountryCode!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: textfield(
                                controller: number,
                                text: "Mobile number",
                                keyboardType: TextInputType.number,
                                fieldColor: AppColors.bgColor,
                                labelColor: AppColors.greyColor,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Mobile Number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .02),
                      textfield(
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          return null;
                        },
                        // obscureText_,

                        text: "Your password",
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
                                    color: AppColors.greyColor)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .02),
                      textfield(
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
                        obstacle: obscureText_,
                        suffix: GestureDetector(
                          onTap: () {
                            toggle();
                          },
                          child: !obscureText_
                              ? const Icon(Icons.visibility,
                                  color: AppColors.darkblue)
                              : const Icon(Icons.visibility_off,
                                  color: AppColors.greyColor),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        children: [
                          Ink(
                            width: Get.width * 0.12,
                            child: Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                activeColor: AppColors.appColor,
                                value: status,
                                onChanged: (value) {
                                  setState(() {});
                                  status = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.015),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  text: "By continuing, ",
                                  style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 12),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "You agree to GoEvent's \n".tr),
                                    TextSpan(
                                        text: 'Terms of Use '.tr,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2.5),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Get.to(() => Loream(
                                            //     "Terms & Conditions"
                                            //         .tr));
                                          }),
                                    const TextSpan(text: "and "),
                                    TextSpan(
                                        text: 'Privacy Policy.'.tr,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2.5),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Get.to(() => Loream(
                                            //     "Terms & Conditions"
                                            //         .tr));
                                          }),
                                  ]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.05),
                      GestureDetector(
                        onTap: () {
                          authSignUp();
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.appColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.whiteColor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .07),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ".tr,
                            style: const TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontFamily: 'Gilroy Medium'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginScreen(),
                                  duration: Duration.zero);
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Color(0xFFFF214A),
                                  fontFamily: 'Gilroy Medium'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //
  authSignUp() async {
    if (name.text.isEmpty) {
      AppConstant.showToastMessage("Please Enter Your Name");
      return;
    }
    if (number.text.isEmpty) {
      AppConstant.showToastMessage("Please Enter Your Mobile Number");
      return;
    }
    // if (number.toString().length != 10) {
    //   AppConstant.showToastMessage("Please Provide a Valid Mobile Number");

    //   return;
    // }
    if (email.text.isEmpty) {
      AppConstant.showToastMessage("Please Enter Your Email");
      return;
    }
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
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      setState(() {});
      CommonRes response = await AuthRepository().mobileEmailCheckApiCall(
          email: email.text.trim(), mobile: number.text.trim());
      if (response.responseCode == "200") {
        verifyPhone("${_selectedCountryCode}" "${number.text}");
      } else {
        AppConstant.showToastMessage(response.responseMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {});
    }
    // var mcheck = {"mobile": number.text, "email": email.text.trim()};

    // if (name.text.isNotEmpty &&
    //         email.text.isNotEmpty &&
    //         number.text.isNotEmpty &&
    //         fpassword.text.isNotEmpty &&
    //         spassword.text.isNotEmpty
    //     // &&        referral.text.isNotEmpty
    //     ) {
    //   if ((RegExp(
    //           r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+")
    //       .hasMatch(email.text))) {
    //     if (fpassword.text == spassword.text) {
    //       if (status == true) {
    //         ApiWrapper.dataPost(Config.mobilecheck, mcheck).then((val) {
    //           if ((val != null) && (val.isNotEmpty)) {
    //             if (val["Result"] == "true") {
    //               setState(() {
    //                 isLoading = true;
    //               });
    //               var register = {
    //                 "UserName": name.text.trim(),
    //                 "Usernumber": number.text.trim(),
    //                 "UserEmail": email.text.trim(),
    //                 "Ccode": _selectedCountryCode,
    //                 "FPassword": fpassword.text.trim(),
    //                 "SPassword": spassword.text.trim(),
    //                 "ReferralCode": referral.text.trim(),
    //               };
    //               save("User", register);

    //               verifyPhone("${_selectedCountryCode}" "${number.text}");
    //             } else {
    //               setState(() {
    //                 isLoading = false;
    //               });
    //               ApiWrapper.showToastMessage(val['ResponseMsg']);
    //             }
    //           }
    //         });
    //       } else {
    //         ApiWrapper.showToastMessage("Accept terms & Condition is required");
    //       }
    //     } else {
    //       ApiWrapper.showToastMessage("password not match");
    //     }
    //   } else {
    //     ApiWrapper.showToastMessage('Please enter valid email address');
    //   }
    // } else {
    //   ApiWrapper.showToastMessage("Please fill required field!");
    // }
  }

  Future<void> verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      // timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {
        AppConstant.showToastMessage("Auth Completed!");
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        AppConstant.showToastMessage("Auth Failed!");
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        AppConstant.showToastMessage("OTP Sent!");
        setState(() {
          isLoading = false;
        });
        // Get.to(() => Verification(verID: verificationId, number: number));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // ApiWrapper.showToastMessage("Timeout!");
        setState(() {
          isLoading = false;
        });
      },
    );
  }
}



//15900 + 5700 = 21600


