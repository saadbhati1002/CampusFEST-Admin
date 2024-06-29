import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int? index;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                const Text(
                  "EXPLORE MORE",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.appColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  rowIndex: 0,
                  imagePath: "assets/category.png",
                  onTap: () {
                    if (index == 0) {
                      index = null;
                    } else {
                      index = 0;
                    }
                    setState(() {});
                  },
                  title: "Category",
                ),
                if (index == 0) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  commonRaw2(
                    onTap: () {},
                    title: "Add Category",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  commonRaw2(
                    onTap: () {},
                    title: "List Category",
                  ),
                ],
                const SizedBox(
                  height: 10,
                ),
                commonRaw(
                  imagePath: "assets/user.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AddRecipeScreen(),
                    //   ),
                    // );
                  },
                  title: "Total Tickets",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Coupon Code",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Coupon Code",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/event.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const MyPlanesScreen(),
                    //   ),
                    // );
                  },
                  title: "Events",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Events",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Events",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/sale.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const MyRecipesScreen(),
                    //   ),
                    // );
                  },
                  title: "Type & Price",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Type & Price",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List  Type & Price",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/gallery.png",
                  onTap: () {},
                  title: "Cover images",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Cover Images",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Cover Images",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/gallery.png",
                  onTap: () {},
                  title: "Events Gallery",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Gallery",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Gallery",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/page.png",
                  onTap: () {},
                  title: "Events Sponsors",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Sponsors",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Sponsors",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/page.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const FeedbackScreen(),
                    //   ),
                    // );
                  },
                  title: "Pages",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add pages",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Pages",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/faq.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const FAQsScreen(),
                    //   ),
                    // );
                  },
                  title: "Payment List",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/offer.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const FollowUsScreen(),
                    //   ),
                    // );
                  },
                  title: "faq Category",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Faq Category",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Faq Category",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/faq.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const LoginScreen(),
                    //   ),
                    // );
                  },
                  title: "Faq",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "Add Faq",
                ),
                commonRaw2(
                  onTap: () {},
                  title: "List Faq",
                ),
                const SizedBox(
                  height: 20,
                ),
                commonRaw(
                  imagePath: "assets/tickets.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const LoginScreen(),
                    //   ),
                    // );
                  },
                  title: "Use List",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonRaw({
    String? imagePath,
    String? title,
    int? rowIndex,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  imagePath!,
                  color: AppColors.boxColor,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title!,
                style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.boxColor,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: rowIndex == index ? 10 : 15),
            child: Icon(
              rowIndex == index
                  ? Icons.keyboard_arrow_down
                  : Icons.arrow_forward_ios,
              color: AppColors.boxColor,
              size: rowIndex == index ? 30 : 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget commonRaw2({
    String? title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 35),
        child: Text(
          title!,
          style: const TextStyle(
              fontSize: 16,
              color: AppColors.greyDarkColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
