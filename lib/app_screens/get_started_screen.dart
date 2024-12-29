import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_colors.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

import '../app_utils/app_functions.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildImageFun(
                        context,
                        AppConstants.getStartedImage,
                      ),
                      Center(
                        child: buildTextFun(
                            context, AppConstants.welcomeToVaadagai,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                      ),
                      buildSizedBoxHeightFun(context, height: 10),
                      buildVaadagaiLogo(context, AppConstants.vaadagaiLogoUrl,
                          height: 70, width: 80),
                      buildSizedBoxHeightFun(context, height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: buildTextFun(
                          context,
                          AppConstants.getStartedDescription,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                left: 60,
                right: 60,
                child: buildContainerButtonFun(context, AppConstants.getStarted,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.orange, onPressed: () {
                  print('Get Started button clicked!');
                  Get.offNamed(AppRouter.REGISTER_SCREEN);
                })),
          ],
        ),
      ),
    );
  }
}
