import 'package:event/screens/event/event_list_screen.dart';
import 'package:event/screens/home/home_screen.dart';
import 'package:event/screens/ticket/ticket_list_screen.dart';
import 'package:event/screens/user/admin_list_screen.dart';
import 'package:event/screens/user/user_list_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late int lastTimeBackButtonWasTapped;
  static const exitTimeInMills = 2000;
  int _selectedIndex = 0;
  final _pageOption = [
    const HomeScreen(),
    const EventListScreen(),
    const TicketListScreen(),
    const UserListScreen(),
    const AdminListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: AppColors.greyColor,
              backgroundColor: AppColors.whiteColor,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'Gilroy_Medium',
                fontWeight: FontWeight.w500,
              ),
              fixedColor: AppColors.buttonColor,
              unselectedFontSize: 13,
              selectedFontSize: 13,
              unselectedLabelStyle:
                  const TextStyle(fontFamily: 'Gilroy_Medium'),
              currentIndex: _selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: _selectedIndex == 0
                          ? AppColors.buttonColor
                          : AppColors.greyColor,
                      // height: MediaQuery.of(context).size.height / 35
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.event_available_outlined,
                      color: _selectedIndex == 1
                          ? AppColors.buttonColor
                          : AppColors.greyColor,
                      // height: MediaQuery.of(context).size.height / 33,
                    ),
                    label: 'Event'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.library_books_rounded,
                      color: _selectedIndex == 2
                          ? AppColors.buttonColor
                          : AppColors.greyColor,
                      // height: MediaQuery.of(context).size.height / 35,
                    ),
                    label: 'Booking'),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervised_user_circle_outlined,
                    color: _selectedIndex == 3
                        ? AppColors.buttonColor
                        : AppColors.greyColor,
                    // height: MediaQuery.of(context).size.height / 35,
                  ),
                  label: 'User',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.assignment_ind_outlined,
                    color: _selectedIndex == 4
                        ? AppColors.buttonColor
                        : AppColors.greyColor,
                    // height: MediaQuery.of(context).size.height / 35,
                  ),
                  label: 'Admin',
                ),
              ],
              onTap: (index) {
                setState(() {});
                _selectedIndex = index;
              }),
          body: _pageOption[_selectedIndex]),
    );
  }

  Future<bool> _handleWillPop() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if ((currentTime - lastTimeBackButtonWasTapped) < exitTimeInMills) {
      return true;
    } else {
      lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      return false;
    }
  }
}
