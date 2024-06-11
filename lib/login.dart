// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event/home_page.dart';
import 'package:event/agent_chat_screen/auth_service.dart';
import 'package:event/api/Api_werper.dart';
import 'package:event/api/Data_save.dart';
import 'package:event/api/confrigation.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/custom_widget.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final Mobile = TextEditingController();
  final password = TextEditingController();
  bool isChecked = false;
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String pagerought = "";
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
      body: SingleChildScrollView(
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
                        controller: Mobile,
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
                        login(Mobile.text, password.text);
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
                color: AppColors.greenColor.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  login(String email, String password) async {
    try {
      Map map = {"email": email, "password": password};
      Uri uri = Uri.parse(AppUrl.login);

      var response = await http.post(uri, body: jsonEncode(map));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        pagerought = result["Result"];
        save("currency", result["currency"]);
        save("AdminLogin", result["AdminLogin"]);

        if (pagerought == "true") {
          AuthService().singUpAndStore(
              email: result["AdminLogin"]["username"],
              uid: result["AdminLogin"]["id"],
              proPicPath: "null");
          Get.to(() => const ScanPage());
        } else {
          ApiWrapper.showToastMessage(result["ResponseMsg"]);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
