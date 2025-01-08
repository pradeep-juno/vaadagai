import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_model/rent_model.dart';

import '../../../app_controller/add_property_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class AgentAddRentScreen extends StatefulWidget {
  const AgentAddRentScreen({super.key});

  @override
  State<AgentAddRentScreen> createState() => _AgentAddSaleScreenState();
}

class _AgentAddSaleScreenState extends State<AgentAddRentScreen> {
  RentModel? rentModel;

  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final args = Get.arguments;
    if (args is RentModel) {
      rentModel = args;
    } else {
      rentModel = null;
      debugPrint("Get.arguments is null or not of type RentModel.");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearFields();
      if (rentModel != null) {
        print("Edit RentId: ${rentModel!.rentId}");

        addPropertyController.isRentEditId.value = true;

        print("isRentEditId: ${addPropertyController.isRentEditId}");

        addPropertyController.selectedPropertyType.value =
            rentModel!.addPropertyType;
        addPropertyController.addPostalCodeController.text =
            rentModel!.addPostalCode.toString();
        addPropertyController.addUnitController.text =
            rentModel!.addUnit.toString();
        addPropertyController.addStreetController.text =
            rentModel!.addStreet.toString();
        addPropertyController.addFloorNoController.text =
            rentModel!.addFloorNo.toString();
        addPropertyController.addSqftController.text =
            rentModel!.addSqft.toString();
        addPropertyController.addBhkController.text =
            rentModel!.addBhk.toString();
        addPropertyController.addBathroomsController.text =
            rentModel!.addBathrooms.toString();
        addPropertyController.addAdvanceController.text =
            rentModel!.addAdvance.toString();
        addPropertyController.addRentController.text =
            rentModel!.addRent.toString();
        addPropertyController.addAdditionalDetailsController.text =
            rentModel!.addAdditionalDetails.toString();
      }
    });
  }

  void clearFields() {
    addPropertyController.clearController(context); // No need for Obx
  }

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
                      Obx(() {
                        return buildAgentHeaderFun(
                            context,
                            addPropertyController.isRentEditId.value
                                ? AppConstants.updateProperty
                                : AppConstants.addProperty);
                      }),
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
              child: buildAgentAddRentButtonFun(
                  context, addPropertyController, rentModel),
            ),
          ],
        ),
      ),
    );
  }
}
