import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CommonSkeleton extends StatelessWidget {
  const CommonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        shadowColor: AppColors.appColor,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      randomLength: false,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      randomLength: false,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      randomLength: true,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 10,
                      randomLength: true,
                      borderRadius: BorderRadius.circular(10),
                      width: MediaQuery.of(context).size.width * .85,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 10,
                          randomLength: false,
                          borderRadius: BorderRadius.circular(10),
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
