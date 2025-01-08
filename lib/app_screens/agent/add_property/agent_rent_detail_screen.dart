import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_model/rent_model.dart';

import '../../../app_controller/add_property_controller.dart';
import '../../../app_utils/app_constants.dart';
import '../../../app_utils/app_functions.dart';
import '../../profile_screen/agent_profile_screen.dart';

class AgentRentDetailScreen extends StatefulWidget {
  const AgentRentDetailScreen({super.key});

  @override
  State<AgentRentDetailScreen> createState() => _AgentRentDetailScreenState();
}

class _AgentRentDetailScreenState extends State<AgentRentDetailScreen> {
  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

  RentModel? rentModel;

  @override
  void initState() {
    super.initState();

    rentModel = Get.arguments as RentModel;

    print("Rent ID : ${rentModel?.rentId}");

    addPropertyController
        .listenToRentPropertyDetailsDataUpdates(rentModel!.rentId);
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
                  buildPropertyRentDetailsHeaderFun(
                    context,
                    AppConstants.propertyDetails,
                    rentModel,
                    addPropertyController,
                  ),
                  Expanded(
                      child: buildCustomScrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16), // Adjust content padding
                      child: buildRentPropertyDetails(
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

buildRentPropertyDetails(
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
              subTitle: addPropertyController.rentPropertyType),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.postalCode,
              subTitle: addPropertyController.rentPostalCode),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.unit,
              subTitle: addPropertyController.rentUnit),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.street,
              subTitle: addPropertyController.rentStreet),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.floorNo,
              subTitle: addPropertyController.rentFloorNo),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.builtUpAreaSqft,
              subTitle: addPropertyController.rentSqft),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.bhk, subTitle: addPropertyController.rentBhk),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.bathrooms,
              subTitle: addPropertyController.rentBathrooms),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.advance,
              subTitle: addPropertyController.rentAdvance),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.rent,
              subTitle: addPropertyController.addRent),
          buildSizedBoxHeightFun(context, height: 16),
          buildTitleSubtitleWithColumn(context,
              title: AppConstants.additionalDetails,
              subTitle: addPropertyController.rentAdditionalDetails),
          buildSizedBoxHeightFun(context, height: 50),
        ],
      ),
    ),
  );
}
