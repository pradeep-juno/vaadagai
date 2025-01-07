import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/user_profile_controller.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

import '../../app_controller/agent_controller.dart';
import '../../app_controller/auth_controller.dart';
import '../../app_utils/app_colors.dart';
import '../../app_utils/app_constants.dart';
import '../app_nav_bar/agent_more_screen.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  final AgentController controller = Get.put(AgentController());
  final AuthController authController = Get.put(AuthController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    userProfileController.listenToUserProfileDataUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                buildProfileHeaderFun(context, '', controller),
                buildSizedBoxHeightFun(context, height: 12),
                buildUserProfile(
                    context, userProfileController, authController),
              ],
            ),
            Obx(() {
              return authController.isLoading.value
                  ? loadingProgress(context)
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}

buildUserProfile(
    BuildContext context,
    UserProfileController userProfileController,
    AuthController authController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildIconTextFunction(
            context,
            image: AppConstants.myProfileIConImage,
            text: AppConstants.myProfile,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            onTap: () {},
          ),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.name,
              subTitle: userProfileController.authName),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.emailAddress,
              subTitle: userProfileController.authEmailAddress),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.mobileNumber,
              subTitle: userProfileController.authMobileNumber),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.profile,
              subTitle: userProfileController.authAs),
          buildSizedBoxHeightFun(context, height: 40),

          //change password

          buildIconTextFunction(
            context,
            image: AppConstants.changePasswordIconImage,
            text: AppConstants.changePassword,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            onTap: () {},
          ),

          buildSizedBoxHeightFun(context, height: 16),

          //delete account

          buildIconTextFunction(
            context,
            image: AppConstants.deleteIconImage,
            text: AppConstants.deleteAccount,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            onTap: () {
              authController.deleteAccount(context);
              //  Get.find<AuthController>().deleteAccount(context);
            },
          ),

          buildSizedBoxHeightFun(context, height: 16),

          //logout

          buildIconTextFunction(
            context,
            image: AppConstants.logoutIconImage,
            text: AppConstants.logout,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

buildTitleSubtitleWithColumn(BuildContext context,
    {required String title, required RxString subTitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildTextFun(context, title,
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black),
      buildSizedBoxHeightFun(context, height: 12),
      Obx(() {
        return buildTextFun(context, subTitle.value,
            fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.grey);
      })
    ],
  );
}
