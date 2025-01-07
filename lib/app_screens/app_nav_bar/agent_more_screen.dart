import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_colors.dart';

import '../../app_utils/app_constants.dart';
import '../../app_utils/app_functions.dart';

class AgentMoreScreen extends StatefulWidget {
  const AgentMoreScreen({super.key});

  @override
  State<AgentMoreScreen> createState() => _AgentMoreScreenState();
}

class _AgentMoreScreenState extends State<AgentMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    buildIconTextFunction(
                      context,
                      image: AppConstants.myHistoryIconImage,
                      text: AppConstants.myHistory,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black,
                      onTap: () {
                        // Handle My History tap
                      },
                    ),
                    const Divider(),
                    buildSizedBoxHeightFun(context, height: 20),
                    buildIconTextFunction(
                      context,
                      image: AppConstants.myProfileIConImage,
                      text: AppConstants.myProfile,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black,
                      onTap: () {
                        Get.offNamed(AppRouter.AGENT_PROFILE_SCREEN);
                      },
                    ),
                    const Divider(),
                    buildSizedBoxHeightFun(context, height: 20),
                    buildIconTextFunction(
                      context,
                      image: AppConstants.switchIconImage,
                      text: AppConstants.switchToBuyer,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black,
                      onTap: () {},
                    ),
                    const Divider(),
                    buildSizedBoxHeightFun(context, height: 20),
                    buildIconTextFunction(
                      context,
                      image: AppConstants.logoutIconImage,
                      text: AppConstants.logout,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black,
                      onTap: () {
                        logout(context);
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildIconTextFunction(
  BuildContext context, {
  required String image,
  required String text,
  required double fontSize,
  required FontWeight fontWeight,
  required Color textColor,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        buildImageFun(context, image),
        buildSizedBoxWidthFun(context, width: 10),
        buildTextFun(
          context,
          text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ],
    ),
  );
}
