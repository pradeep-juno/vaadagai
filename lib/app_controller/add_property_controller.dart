import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

import '../app_model/sale_model.dart';
import '../app_utils/app_constants.dart';

class AddPropertyController extends GetxController {
  final List<String> propertyTypeItems = [
    AppConstants.individualHouse,
    AppConstants.flatsApartments,
  ];
  RxString selectedPropertyType = ''.obs;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final addPostalCodeController = TextEditingController();
  final addUnitController = TextEditingController();
  final addStreetController = TextEditingController();
  final addTotalFloorsController = TextEditingController();
  final addFloorNoController = TextEditingController();
  final addSqftController = TextEditingController();
  final addBhkController = TextEditingController();
  final addBathroomsController = TextEditingController();
  final addPriceController = TextEditingController();
  final addAdditionalDetailsController = TextEditingController();

  Future<void> addProperty(BuildContext context) async {
    if (await addPropertyValidationFields(context)) {
      try {
        var docRef =
            firebaseFirestore.collection(AppConstants.collectionForSale).doc();
        var saleId = docRef.id;
        var saleData = SaleModel(
            saleId: saleId,
            addPropertyType: selectedPropertyType.value,
            addPostalCode: addPostalCodeController.text.trim(),
            addUnit: addUnitController.text.trim(),
            addStreet: addStreetController.text.trim(),
            addTotalFloors: addTotalFloorsController.text.trim(),
            addFloorNo: addFloorNoController.text.trim(),
            addSqft: addSqftController.text.trim(),
            addBhk: addBhkController.text.trim(),
            addBathrooms: addBathroomsController.text.trim(),
            addPrice: addPriceController.text.trim(),
            addAdditionalDetails: addAdditionalDetailsController.text.trim());

        await docRef.set(saleData.toMap());

        print(saleData.toString());

        buildScaffoldMessage(context, "successfully Add Sale Details");

        clearController(context);
      } catch (e) {
        buildScaffoldMessage(context, "fail to add Sale : $e");
      }
    }
  }

  addPropertyValidationFields(BuildContext context) {
    String addPropertyType = selectedPropertyType.value;
    String addPostalCode = addPostalCodeController.text.trim();
    String addUnit = addUnitController.text.trim();
    String addStreet = addStreetController.text.trim();
    String addTotalFloors = addTotalFloorsController.text.trim();
    String addFloorNo = addFloorNoController.text.trim();
    String addSqft = addSqftController.text.trim();
    String addBhk = addBhkController.text.trim();
    String addBathrooms = addBathroomsController.text.trim();
    String addPrice = addPriceController.text.trim();
    String addAdditionalDetails = addAdditionalDetailsController.text.trim();

    if (addPropertyType.isEmpty) {
      buildScaffoldMessage(context, "Choose Property");
      return false;
    }
    if (addPostalCode.isEmpty) {
      buildScaffoldMessage(context, "Enter Your Postal Code");
      return false;
    }
    if (addUnit.isEmpty) {
      buildScaffoldMessage(context, "Please Add Unit");
      return false;
    }
    if (addStreet.isEmpty) {
      buildScaffoldMessage(context, "Please Add Street");
      return false;
    }
    if (addFloorNo.isEmpty) {
      buildScaffoldMessage(context, "Please Add Total Floors");
      return false;
    }
    if (addTotalFloors.isEmpty) {
      buildScaffoldMessage(context, "Please Add Floor Number");
      return false;
    }
    if (addSqft.isEmpty) {
      buildScaffoldMessage(context, "Please Add  Square Feet");
      return false;
    }
    if (addBhk.isEmpty) {
      buildScaffoldMessage(context, "Please Add  BHK");
      return false;
    }
    if (addBathrooms.isEmpty) {
      buildScaffoldMessage(context, "Please Add  Bathrooms");
      return false;
    }

    if (addPrice.isEmpty) {
      buildScaffoldMessage(context, "Please Add  Price");
      return false;
    }

    if (addAdditionalDetails.isEmpty) {
      buildScaffoldMessage(context, "Please Add  Description");
      return false;
    }

    return true;
  }

  void clearController(BuildContext context) {
    selectedPropertyType.value = '';
    addPostalCodeController.clear();
    addUnitController.clear();
    addStreetController.clear();
    addTotalFloorsController.clear();
    addFloorNoController.clear();
    addSqftController.clear();
    addBhkController.clear();
    addBathroomsController.clear();
    addPriceController.clear();
    addAdditionalDetailsController.clear();
  }
}
