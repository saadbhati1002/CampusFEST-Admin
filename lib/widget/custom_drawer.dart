import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                  imagePath: "assets/category.png",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const HomeMakerScreen(),
                    //   ),
                    // );
                  },
                  title: "Category",
                ),
                commonRaw2(
                    onTap: () {},
                    title1: "Add Category",
                    title2: "List Category"),
                const SizedBox(
                  height: 20,
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
                  title1: "Add Coupon Code",
                  title2: "List Coupon Code",
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
                  title1: "Add Events",
                  title2: "List Events",
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
                  title1: "Add Type & Price",
                  title2: "List  Type & Price",
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
                  title1: "Add Cover Images",
                  title2: "List Cover Images",
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
                  title1: "Add Gallery",
                  title2: "List Gallery",
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
                  title1: "Add Sponsors",
                  title2: "List Sponsors",
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
                  title1: "Add pages",
                  title2: "List Pages",
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
                  title1: "Add Category",
                  title2: "List Category",
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
                  title1: "Add Faq",
                  title2: "List Faq",
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
                    fontSize: 16,
                    color: AppColors.boxColor,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.boxColor,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget commonRaw2({
    String? title1,
    String? title2,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title1!,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.boxColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                title2!,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.boxColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
