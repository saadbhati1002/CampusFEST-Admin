import 'dart:convert';
import 'package:event/api/repository/auth.dart';
import 'package:event/model/auth/login_model.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event/home_page.dart';
import 'package:event/agent_chat_screen/auth_service.dart';

import 'package:event/api/Data_save.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  bool isChecked = false;
  bool _obscureText = true;
  bool isLoading = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        backButton: const BackButton(
          color: AppColors.blackColor,
        ),
        actionIcon: null,
        center: true,
        centerText: "Login",
        onClick: () {},
        radius: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Let's Sign You In",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 22,
                            color: AppColors.blackColor),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("Welcome back, you've been missed",
                          style: TextStyle(
                              fontFamily: "Gilroy Medium",
                              fontSize: 18,
                              color: AppColors.blackColor)),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: textfield(
                            controller: mobile,
                            fieldColor: AppColors.bgColor,
                            labelColor: AppColors.greyColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              return null;
                            },
                            text: "Enter Your Email")),
                    Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: passwordTextfield()),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                              unselectedWidgetColor: AppColors.blackColor),
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            value: isChecked,
                            activeColor: AppColors.blackColor,
                            onChanged: (value) {
                              setState(
                                () {
                                  isChecked = value!;
                                  save("Remember", value);
                                },
                              );
                            },
                          ),
                        ),
                        const Text(
                          "Remember Me",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Gilroy Medium",
                              color: AppColors.blackColor),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: GestureDetector(
                        onTap: () {
                          if ((_formKey.currentState?.validate() ?? false)) {
                            login(mobile.text, password.text);
                          }
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.whiteColor,
                                  fontFamily: "Gilroy Bold"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Widget passwordTextfield() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: password,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.blackColor,
        ),
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: () {
                _toggle();
              },
              child: !_obscureText
                  ? const Icon(Icons.visibility, color: AppColors.darkblue)
                  : const Icon(Icons.visibility_off,
                      color: AppColors.greyColor)),
          labelText: "Password",
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.darkblue),
            borderRadius: BorderRadius.circular(15),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyColor.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Future login(String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      LoginRes response = await AuthRepository()
          .userLoginApiCall(email: email, password: password);
      if (response.responseCode == "200") {
        save("currency", response.currency);
        save("AdminLogin", jsonEncode(response.adminLogin));
        AuthService().singUpAndStore(
            email: response.adminLogin!.username!,
            uid: response.adminLogin!.id!,
            proPicPath: "null");
        Get.to(() => const ScanPage());
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
