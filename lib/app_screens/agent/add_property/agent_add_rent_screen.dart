import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_controller/add_property_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class AgentAddRentScreen extends StatefulWidget {
  const AgentAddRentScreen({super.key});

  @override
  State<AgentAddRentScreen> createState() => _AgentAddSaleScreenState();
}

class _AgentAddSaleScreenState extends State<AgentAddRentScreen> {
  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

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
                    children: [
                      buildAgentHeaderFun(context, AppConstants.addProperty),
                      buildSizedBoxHeightFun(context, height: 30),
                      buildAgentAddRentBodyFun(
                        context,
                        addPropertyController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 60,
              right: 60,
              child: buildAgentAddRentButtonFun(context, addPropertyController),
            ),
          ],
        ),
      ),
    );
  }
}
