import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_screens/app_nav_bar/agent_home_screen.dart';
import 'package:vaadagai/app_screens/app_nav_bar/agent_more_screen.dart';
import 'package:vaadagai/app_screens/app_nav_bar/agent_schedules_screen.dart';
import 'package:vaadagai/app_utils/app_colors.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';
import 'package:vaadagai/storage_services/users_storage_service.dart';

import '../../app_controller/agent_controller.dart';

class AgentMainScreen extends StatefulWidget {
  const AgentMainScreen({super.key});

  @override
  State<AgentMainScreen> createState() => _AgentMainScreenState();
}

class _AgentMainScreenState extends State<AgentMainScreen> {
  final AgentController controller = Get.put(AgentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // int initialIndex = Get.arguments ?? 0;
      // controller.selectedIndex.value = initialIndex;
      String userId = UsersStorageService.getUserId().toString();
      print("AGENT_MAIN_SCREEN : USER_ID => $userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: BottomBar(
        width: MediaQuery.of(context).size.width,
        //hideOnScroll: true,
        borderRadius: BorderRadius.circular(20),
        barColor: AppColors.primaryBlue,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildNavItem(
                    icon: Icons.home,
                    index: 0,
                    selectedColor: AppColors.backgroundWhite,
                    unselectedColor: AppColors.lytBlue,
                    onPressed: () => controller.changeIndex(0),
                    controller: controller,
                    title: AppConstants.home,
                    context: context),
                buildNavItem(
                    icon: Icons.schedule,
                    index: 1,
                    selectedColor: AppColors.backgroundWhite,
                    unselectedColor: AppColors.lytBlue,
                    onPressed: () => controller.changeIndex(1),
                    controller: controller,
                    title: AppConstants.schedules,
                    context: context),
                buildNavItem(
                    icon: Icons.more_horiz,
                    index: 2,
                    selectedColor: AppColors.backgroundWhite,
                    unselectedColor: AppColors.lytBlue,
                    onPressed: () => controller.changeIndex(2),
                    controller: controller,
                    title: AppConstants.more,
                    context: context)
              ],
            );
          }),
        ),
        body: (context, _controller) => Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
              return const AgentHomeScreen();
            case 1:
              return const AgentSchedulesScreen();
            case 2:
              return const AgentMoreScreen();
            default:
              return const AgentHomeScreen();
          }
        }),
      ),
    ));
  }
}

Widget buildNavItem({
  required IconData icon,
  required int index,
  required Color selectedColor,
  required Color unselectedColor,
  required VoidCallback onPressed,
  required AgentController controller,
  required String title,
  required BuildContext context,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(
          size: 20,
          icon,
          color: controller.selectedIndex.value == index
              ? selectedColor
              : unselectedColor,
        ),
        onPressed: onPressed,
      ),
      buildTextFun(
        context,
        title,
        fontSize: 10,
        fontWeight: controller.selectedIndex.value == index
            ? FontWeight.bold
            : FontWeight.w500,
        color: controller.selectedIndex.value == index
            ? selectedColor
            : unselectedColor,
      ),
      buildSizedBoxHeightFun(context, height: 4),
      if (controller.selectedIndex.value == index) ...[
        Column(
          children: [
            Container(
              height: 3,
              width: 40,
              color: Colors.white,
            ),
            buildSizedBoxHeightFun(context, height: 4),
          ],
        )
      ]
    ],
  );
}
