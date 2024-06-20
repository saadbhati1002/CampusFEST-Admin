import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageCircular extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;

  const CustomImageCircular({
    super.key,
    this.height,
    this.imagePath,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return (imagePath != null && imagePath!.isNotEmpty)
        ? CachedNetworkImage(
            imageUrl: "${AppConstant.baseUrl}$imagePath",
            imageBuilder: (context, imageProvider) {
              return Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).hoverColor,
                highlightColor: Theme.of(context).highlightColor,
                enabled: true,
                child: Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                    image: const DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).hoverColor,
                highlightColor: Theme.of(context).highlightColor,
                enabled: true,
                child: Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: AppColors.greyColor),
                    image: const DecorationImage(
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: AppColors.greyColor),
              image: const DecorationImage(
                image: AssetImage("assets/logo.png"),
              ),
            ),
          );
  }
}
