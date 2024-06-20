import 'package:event/utils/Colors.dart';
import 'package:event/widget/custom_image_view_circular.dart';
import 'package:flutter/material.dart';

appBarMain({
  BuildContext? context,
  VoidCallback? onTap,
}) {
  return AppBar(
    backgroundColor: AppColors.whiteColor,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.asset("assets/drawer.png"),
          ),
          Container(
            color: Colors.transparent,
            height: 45,
            child: Image.asset("assets/get_event.png"),
          ),
          const CustomImageCircular(
            height: 40,
            width: 40,
            imagePath: null,
          ),
        ],
      ),
    ),
  );
}
