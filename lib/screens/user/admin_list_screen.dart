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
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AdminListScreen extends StatefulWidget {
  const AdminListScreen({super.key});

  @override
  State<AdminListScreen> createState() => _AdminListScreenState();
}

class _AdminListScreenState extends State<AdminListScreen> {
  List<UserData> adminList = [];
  bool isLoading = false;
  bool isApiCallLoading = false;
  @override
  void initState() {
    _getAdminList();
    super.initState();
  }

  Future _getAdminList() async {
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await UserRepository().getAdminListApiCall();
      if (response.users.isNotEmpty) {
        adminList = response.users;
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
    Navigator.pop(context, adminList.length);
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
            Navigator.pop(context, adminList.length);
          },
          title: "Admin List",
        ),
        body: Stack(
          children: [
            !isLoading
                ? ListView.builder(
                    itemCount: adminList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemBuilder: (context, index) {
                      return userWidget(data: adminList[index], index: index);
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
                if (data.id != AppConstant.userData!.id) ...[
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
                          _changeAdminStatus(index: index);
                          userStatus = val;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _adminAccountDelete(index: index);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.greyColor,
                        ),
                      )
                    ],
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _changeAdminStatus({int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await UserRepository().adminStatusChangeApiCall(
          userID: adminList[index!].id,
          status: adminList[index].status == "Active" ? 0 : 1);
      if (response.responseCode == "200") {
        adminList[index].status =
            adminList[index].status == "Active" ? "Inactive" : "Active";
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiCallLoading = false;
      });
    }
  }

  Future _adminAccountDelete({int? index}) async {
    try {
      setState(() {
        isApiCallLoading = true;
      });

      CommonRes response = await UserRepository().userAccountDeleteApiCall(
        userID: adminList[index!].id,
      );
      if (response.responseCode == "200") {
        adminList.removeAt(index);
        AppConstant.showToastMessage("Account deleted successfully");
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
