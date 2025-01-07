import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_model/sale_model.dart';

import '../../../app_controller/add_property_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';

class AgentAddSaleScreen extends StatefulWidget {
  const AgentAddSaleScreen({super.key});

  @override
  State<AgentAddSaleScreen> createState() => _AgentAddSaleScreenState();
}

class _AgentAddSaleScreenState extends State<AgentAddSaleScreen> {
  SaleModel? saleModel;

  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

  @override
  void initState() {
    super.initState();

    // Safely retrieve and cast the arguments
    final args = Get.arguments;
    if (args is SaleModel) {
      saleModel = args;
    } else {
      saleModel = null;
      debugPrint("Get.arguments is null or not of type SaleModel.");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      clearFields();
      if (saleModel != null) {
        print("Edit SaleId: ${saleModel!.saleId}");

        addPropertyController.isSaleEditId.value = true;

        print("isSaleEditId: ${addPropertyController.isSaleEditId}");

        addPropertyController.selectedPropertyType.value =
            saleModel!.addPropertyType;
        addPropertyController.addPostalCodeController.text =
            saleModel!.addPostalCode.toString();
        addPropertyController.addUnitController.text =
            saleModel!.addUnit.toString();
        addPropertyController.addStreetController.text =
            saleModel!.addStreet.toString();
        addPropertyController.addTotalFloorsController.text =
            saleModel!.addTotalFloors.toString();
        addPropertyController.addFloorNoController.text =
            saleModel!.addFloorNo.toString();
        addPropertyController.addSqftController.text =
            saleModel!.addSqft.toString();
        addPropertyController.addBhkController.text =
            saleModel!.addBhk.toString();
        addPropertyController.addBathroomsController.text =
            saleModel!.addBathrooms.toString();
        addPropertyController.addPriceController.text =
            saleModel!.addPrice.toString();
        addPropertyController.addAdditionalDetailsController.text =
            saleModel!.addAdditionalDetails.toString();
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
                            addPropertyController.isSaleEditId.value
                                ? AppConstants.updateProperty
                                : AppConstants.addProperty);
                      }),
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
              child: buildAgentAddSaleButtonFun(
                  context, addPropertyController, saleModel),
            ),
          ],
        ),
      ),
    );
  }
}
