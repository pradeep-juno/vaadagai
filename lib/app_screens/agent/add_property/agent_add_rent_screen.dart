import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_controller/auth_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class AgentAddRentScreen extends StatefulWidget {
  const AgentAddRentScreen({super.key});

  @override
  State<AgentAddRentScreen> createState() => _AgentAddRentScreenState();
}

class _AgentAddRentScreenState extends State<AgentAddRentScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 120,
              child: buildCustomScrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSizedBoxHeightFun(context, height: 30),
                      buildAuthHeaderFun(context, AppConstants.registerCaps),
                      buildSizedBoxHeightFun(context, height: 30),
                      buildRegisterBodyFun(context, authController),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 60,
              right: 60,
              child: buildRegisterButtonFun(context, authController),
            ),
          ],
        ),
      ),
    );
  }
}
