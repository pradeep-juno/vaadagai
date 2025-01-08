import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_colors.dart';

import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class PropertyAddScreen extends StatefulWidget {
  const PropertyAddScreen({super.key});

  @override
  State<PropertyAddScreen> createState() => _PropertyAddScreenState();
}

class _PropertyAddScreenState extends State<PropertyAddScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPropertyAddHeaderFun(context, AppConstants.addProperty),
              buildSizedBoxHeightFun(context, height: 20),
              // "For Sale" button
              buildContainerButtonFun(
                context,
                AppConstants.forSale,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 50,
                width: double.infinity,
                circle: true,
                circleTextColor: AppColors.black,
                circleColor: AppColors.lightGrey,
                centerText: false,
                borderRadius: 12,
                onPressed: () {
                  print("For Sale clicked");
                  Get.toNamed(AppRouter.AGENT_ADD_SALE_SCREEN, arguments: null);
                },
              ),
              buildSizedBoxHeightFun(context, height: 15),
              // "For Rent" button
              buildContainerButtonFun(
                context,
                AppConstants.forRent,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 50,
                width: double.infinity,
                circle: true,
                fontColor: Colors.black,
                circleColor: AppColors.lightGrey,
                circleTextColor: AppColors.black,
                centerText: false,
                borderRadius: 12,
                onPressed: () {
                  print("For Rent clicked");
                  Get.toNamed(AppRouter.AGENT_ADD_RENT_SCREEN, arguments: null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> goBack() async {
  Get.back();
}
