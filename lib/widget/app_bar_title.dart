import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';

titleAppBar({
  BuildContext? context,
  VoidCallback? onTap,
  String? title,
}) {
  return AppBar(
    elevation: 1,
    backgroundColor: AppColors.whiteColor,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 5),
              height: 23,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.appColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title!,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Gilroy Medium',
                  fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    ),
  );
}
