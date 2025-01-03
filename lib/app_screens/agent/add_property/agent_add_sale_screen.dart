import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_controller/add_property_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class AgentAddSaleScreen extends StatefulWidget {
  const AgentAddSaleScreen({super.key});

  @override
  State<AgentAddSaleScreen> createState() => _AgentAddSaleScreenState();
}

class _AgentAddSaleScreenState extends State<AgentAddSaleScreen> {
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
                      buildAgentAddSaleHeaderFun(
                          context, AppConstants.addProperty),
                      buildSizedBoxHeightFun(context, height: 30),
                      buildAgentAddSaleBodyFun(
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
              child: buildAgentAddSaleButtonFun(context, addPropertyController),
            ),
          ],
        ),
      ),
    );
  }
}
