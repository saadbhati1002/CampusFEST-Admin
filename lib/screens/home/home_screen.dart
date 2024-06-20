import 'package:event/api/repository/dashboard/dashboard.dart';
import 'package:event/model/dashboard/dashboard_model.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/widget/app_bar_main.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  DashboardData? dashboardData;
  @override
  void initState() {
    _getDashboardCount();
    super.initState();
  }

  Future _getDashboardCount() async {
    try {
      setState(() {
        isLoading = true;
      });
      DashboardRes response =
          await DashboardRepository().getDashboardCountApiCall();
      if (response.responseCode == "200") {
        dashboardData = response.dashboardData;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(
        context: context,
      ),
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total User",
                    count: dashboardData?.totalUsers ?? "0",
                    backgroundColor: const Color(0xFF325163),
                    textColor: AppColors.whiteColor,
                    image: "assets/user.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Admin",
                    count: dashboardData?.totalAdmins ?? "0",
                    backgroundColor: const Color(0xFF51C6F9),
                    textColor: AppColors.whiteColor,
                    image: "assets/user.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Category",
                    count: dashboardData?.totalCategories ?? "0",
                    backgroundColor: const Color(0xFF7251F9),
                    textColor: AppColors.whiteColor,
                    image: "assets/category.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Event",
                    count: dashboardData?.totalEvent ?? "0",
                    backgroundColor: const Color(0xFF51F9C6),
                    textColor: AppColors.whiteColor,
                    image: "assets/event.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Tickets",
                    count: dashboardData?.totalTickets ?? "0",
                    backgroundColor: const Color(0xFF5451F9),
                    textColor: AppColors.whiteColor,
                    image: "assets/tickets.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Offers",
                    count: dashboardData?.totalOffers ?? "0",
                    backgroundColor: const Color(0xFF945AA3),
                    textColor: AppColors.whiteColor,
                    image: "assets/offer.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Gallery Image",
                    count: dashboardData?.totalGalleryImages ?? "0",
                    backgroundColor: const Color(0xFF388055),
                    textColor: AppColors.whiteColor,
                    image: "assets/gallery.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total FAQ",
                    count: dashboardData?.totalFaqs ?? "0",
                    backgroundColor: const Color(0xFF368CB1),
                    textColor: AppColors.whiteColor,
                    image: "assets/faq.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total FAQ Category",
                    count: dashboardData?.totalFaqCategories ?? "0",
                    backgroundColor: const Color(0xFFB13D36),
                    textColor: AppColors.whiteColor,
                    image: "assets/faq.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Pages",
                    count: dashboardData?.totalPages ?? "0",
                    backgroundColor: const Color(0xFF23348C),
                    textColor: AppColors.whiteColor,
                    image: "assets/page.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  dashboardBox(
                    title: "Total Revenue",
                    count: "0",
                    backgroundColor: const Color(0xFFCA5C2D),
                    textColor: AppColors.whiteColor,
                    image: "assets/sale.png",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                ],
              ),
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  Widget dashboardBox({
    String? title,
    dynamic count,
    Color? backgroundColor,
    Color? textColor,
    String? image,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
              image: DecorationImage(
                image: AssetImage(image!),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title!,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy Medium',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                count.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy Medium',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
