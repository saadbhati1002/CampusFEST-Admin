// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event/utils/Colors.dart';

textfield(
    {String? text,
    suffix,
    prefix,
    Color? labelColor,
    Function()? onTap,
    fieldColor,
    double? Width,
    Height,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool? obstacle,
    TextInputType? keyboardType}) {
  return Container(
    height: 47,
    width: Width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), color: AppColors.whiteColor),
    child: TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obstacle ?? false,
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: const TextStyle(
          color: AppColors.greyColor,
          fontFamily: "Gilroy Medium",
          fontSize: 14,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(6),
          child: suffix,
        ),
        prefixIcon: prefix ??
            Padding(
              padding: const EdgeInsets.all(6),
              child: prefix,
            ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.darkblue),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.greyColor.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
      validator: validator,
    ),
  );
}

CustomAppBar(
    {String? centerText,
    bool? center,
    Widget? backButton,
    IconData? actionIcon,
    Function()? onClick,
    double? radius}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.whiteColor,
    centerTitle: center,
    title: Text(centerText!,
        style: const TextStyle(
            fontSize: 18,
            color: AppColors.blackColor,
            fontFamily: "Gilroy Bold")),
    leading:
        Transform.translate(offset: const Offset(-6, 0), child: backButton),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: InkWell(
          onTap: onClick,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.greyColor.withOpacity(0.4),
            child: Icon(
              actionIcon,
              color: AppColors.blackColor,
            ),
          ),
        ),
      )
    ],
  );
}

button(clr, text, siz, siz2) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: clr),
      height: Get.height / 15,
      width: Get.width / 1.3,
      child: Row(
        children: [
          siz,
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
          siz2,
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Image.asset("image/arrow.png")),
        ],
      ),
    ),
  );
}

dynamic height;
dynamic width;
