import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/add_property_controller.dart';
import 'package:vaadagai/app_model/sale_model.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

import '../../profile_screen/agent_profile_screen.dart';

class AgentSaleDetailScreen extends StatefulWidget {
  const AgentSaleDetailScreen({super.key});

  @override
  State<AgentSaleDetailScreen> createState() => _AgentSaleDetailScreenState();
}

class _AgentSaleDetailScreenState extends State<AgentSaleDetailScreen> {
  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

  SaleModel? saleModel;

  @override
  void initState() {
    super.initState();

    saleModel = Get.arguments as SaleModel;

    print("Sale ID : ${saleModel?.saleId}");

    addPropertyController
        .listenToSalePropertyDetailsDataUpdates(saleModel!.saleId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPropertyDetailsHeaderFun(
                    context,
                    AppConstants.propertyDetails,
                    saleModel,
                    addPropertyController,
                  ),
                  Expanded(
                      child: buildCustomScrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16), // Adjust content padding
                      child: buildSalePropertyDetails(
                        context,
                        addPropertyController,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              return addPropertyController.isLoading.value
                  ? loadingProgress(context)
                  : const SizedBox.shrink();
            }),
          )
        ],
      )),
    );
  }
}

buildSalePropertyDetails(
  BuildContext context,
  AddPropertyController addPropertyController,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.propertyType,
              subTitle: addPropertyController.addPropertyType),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.postalCode,
              subTitle: addPropertyController.addPostalCode),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.unit,
              subTitle: addPropertyController.addUnit),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.street,
              subTitle: addPropertyController.addStreet),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.totalFloors,
              subTitle: addPropertyController.addTotalFloors),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.floorNo,
              subTitle: addPropertyController.addFloorNo),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.builtUpAreaSqft,
              subTitle: addPropertyController.addSqft),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.bhk, subTitle: addPropertyController.addBhk),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.bathrooms,
              subTitle: addPropertyController.addBathrooms),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.price,
              subTitle: addPropertyController.addPrice),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.additionalDetails,
              subTitle: addPropertyController.addAdditionalDetails),
          buildSizedBoxHeightFun(context, height: 50),
        ],
      ),
    ),
  );
}
