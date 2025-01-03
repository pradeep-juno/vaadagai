import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_utils/app_colors.dart';

import '../../app_router/app_router.dart';
import '../../app_utils/app_constants.dart';
import '../../app_utils/app_functions.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({super.key});

  @override
  State<AgentHomeScreen> createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          buildTopLogoFun(
            context,
            AppConstants.vaadagaiLogoUrl,
          ),
          buildSizedBoxHeightFun(context, height: 6),
          Positioned(
            top: 60,
            bottom: 150,
            child: buildCustomScrollbar(
              child: SingleChildScrollView(
                child: Container(
                  // height: 1000,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildImageFun(
                            context, AppConstants.agentHomeScreenImage,
                            height: 202,
                            width: MediaQuery.of(context).size.width),
                        buildSizedBoxHeightFun(context, height: 16),
                        Row(
                          children: [
                            buildSizedBoxWidthFun(context, width: 8),
                            Icon(Icons.work_history_outlined),
                            buildSizedBoxWidthFun(context, width: 5),
                            buildTextFun(
                              context,
                              AppConstants.myActivities,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 100,
              left: 70,
              right: 60,
              child: Row(
                children: [
                  buildContainerButtonFun(context, AppConstants.addNewProperty,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      showIcon: true,
                      color: AppColors.backgroundWhite, onPressed: () {
                    print('Add new property button clicked!');
                    Get.offNamed(AppRouter.PROPERTY_ADD_SCREEN);
                  },
                      height: 48,
                      width: 220,
                      circle: true,
                      circleColor: AppColors.orange),
                ],
              ))
        ],
      ),
    ));
  }
}
