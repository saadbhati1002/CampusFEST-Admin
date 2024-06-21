import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;
  final bool? isAssetsImage;
  final double? borderRadius;
  const CustomImage(
      {super.key,
      this.height,
      this.imagePath,
      this.width,
      this.isAssetsImage,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return isAssetsImage == true
        ? SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.fill,
            ),
          )
        : (imagePath != null && imagePath!.isNotEmpty)
            ? ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius ?? 15),
                  topRight: Radius.circular(borderRadius ?? 0),
                  bottomLeft: Radius.circular(borderRadius ?? 15),
                  bottomRight: Radius.circular(borderRadius ?? 0),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${AppConstant.imageUrl}$imagePath",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius ?? 15),
                            topRight: Radius.circular(borderRadius ?? 0),
                            bottomLeft: Radius.circular(borderRadius ?? 15),
                            bottomRight: Radius.circular(borderRadius ?? 0),
                          ),
                          color: AppColors.whiteColor,
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(borderRadius ?? 15),
                            topRight: Radius.circular(borderRadius ?? 0),
                            bottomLeft: Radius.circular(borderRadius ?? 15),
                            bottomRight: Radius.circular(borderRadius ?? 0),
                          ),
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
                ),
              )
            : Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius ?? 10),
                    topRight: Radius.circular(borderRadius ?? 0),
                    bottomLeft: Radius.circular(borderRadius ?? 10),
                    bottomRight: Radius.circular(borderRadius ?? 0),
                  ),
                  image: const DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
                ),
              );
  }
}
