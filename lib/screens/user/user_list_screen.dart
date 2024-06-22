import 'package:event/api/repository/user/user.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/user/user_model.dart';
import 'package:event/screens/image_view/image_view_screen.dart';
import 'package:event/utils/Colors.dart';
import 'package:event/utils/constant.dart';
import 'package:event/widget/app_bar_title.dart';
import 'package:event/widget/common_skeleton.dart';
import 'package:event/widget/custom_image_view.dart';
import 'package:event/widget/show_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserData> usersList = [];
  bool isLoading = false;
  bool isApiCallLoading = false;
  @override
  void initState() {
    _getUsersList();
    super.initState();
  }

  Future _getUsersList() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await UserRepository().getUserListApiCall();
      if (response.users.isNotEmpty) {
        usersList = response.users;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _onBackPress() async {
    Navigator.pop(context, usersList.length);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: titleAppBar(
          onTap: () {
            Navigator.pop(context, usersList.length);
          },
          title: "Users List",
        ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: usersList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return userWidget(data: usersList[index], index: index);
                    },
                  )
                : ListView.builder(
                    itemCount: 10,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    itemBuilder: (context, index) {
                      return const CommonSkeleton();
                    },
                  ),
            isApiCallLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget userWidget({UserData? data, int? index}) {
    bool userStatus = false;
    if (data!.status == "Active") {
      userStatus = true;
    } else {
      userStatus = false;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppColors.appColor),
      ),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (data.proPic != null) {
                Get.to(
                  () => FullImageScreen(
                    imageUrl: "${AppConstant.imageUrl}${data.proPic}",
                  ),
                );
              }
            },
            child: CustomImage(
              width: MediaQuery.of(context).size.width * .35,
              height: MediaQuery.of(context).size.height,
              imagePath: data.proPic ?? "",
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * .56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.email ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.appColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.mobile ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Status: ${data.status}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlutterSwitch(
                      width: MediaQuery.of(context).size.width * .1,
                      height: 22,
                      valueFontSize: 10.0,
                      toggleSize: 15.0,
                      value: userStatus,
                      borderRadius: 30.0,
                      padding: 5.0,
                      activeColor: AppColors.appColor,
                      inactiveColor: AppColors.greyColor,
                      inactiveText: "",
                      activeText: "",
                      showOnOff: true,
                      onToggle: (val) {
                        _changeUserStatus(status: val, index: index);
                        userStatus = val;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _userAccountDelete(index: index);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.greyColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _changeUserStatus({bool? status, int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await UserRepository().userStatusChangeApiCall(
          userID: usersList[index!].id,
          status: usersList[index].status == "Active" ? 0 : 1);
      if (response.responseCode == "200") {
        usersList[index].status =
            usersList[index].status == "Active" ? "Inactive" : "Active";
      } else {
        AppConstant.showToastMessage(response.responseMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiCallLoading = false;
      });
    }
  }

  Future _userAccountDelete({int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await UserRepository().userAccountDeleteApiCall(
        userID: usersList[index!].id,
      );
      if (response.responseCode == "200") {
        usersList.removeAt(index);
        AppConstant.showToastMessage("Account deleted successfully");
      } else {
        AppConstant.showToastMessage(response.responseMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiCallLoading = false;
      });
    }
  }
}
