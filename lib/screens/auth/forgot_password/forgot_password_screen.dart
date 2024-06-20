import 'package:event/api/repository/auth.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/screens/auth/verification/verification_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final number = TextEditingController();
  String? selectedCountryCode = "+91";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  String? vID = "";

  verifyPhone() async {
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      setState(() {
        isLoading = true;
      });
      CommonRes response =
          await AuthRepository().mobileCheckApiCall(mobile: number.text.trim());
      if (response.responseCode == "200") {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: selectedCountryCode! + number.text.toString(),
          verificationCompleted: (PhoneAuthCredential credential) {
            AppConstant.showToastMessage("Auth Completed!");
          },
          verificationFailed: (FirebaseAuthException e) {
            AppConstant.showToastMessage("Auth Failed!");
          },
          codeSent: (String verificationId, int? resendToken) {
            AppConstant.showToastMessage("OTP Sent!");
            setState(() {});

            isLoading = false;
            Get.to(() => VerificationScreen(
                verID: verificationId,
                params: {"mobile": number.text.toString()},
                type: "Reset"));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
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
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Reset Password".tr,
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
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Please enter your phone number to",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Gilroy Medium',
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 400),
                          const Text(
                            "request OTP for password reset",
                            style: TextStyle(
                              fontSize: 14,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Ink(
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
                                selectedCountryCode!,
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
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                GestureDetector(
                  onTap: () {
                    if (number.text.isEmpty) {
                      AppConstant.showToastMessage(
                          "Please enter mobile number");
                      return;
                    }
                    verifyPhone();
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.appColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Forgot Password",
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
}
