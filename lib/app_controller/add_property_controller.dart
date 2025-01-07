import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_model/rent_model.dart';
import 'package:vaadagai/app_utils/app_functions.dart';
import 'package:vaadagai/storage_services/users_storage_service.dart';

import '../app_model/sale_model.dart';
import '../app_router/app_router.dart';
import '../app_utils/app_constants.dart';

class AddPropertyController extends GetxController {
  var saleId = ''.obs;
  var addPropertyType = ''.obs;
  var addPostalCode = ''.obs;
  var addUnit = ''.obs;
  var addStreet = ''.obs;
  var addTotalFloors = ''.obs;
  var addFloorNo = ''.obs;
  var addSqft = ''.obs;
  var addBhk = ''.obs;
  var addBathrooms = ''.obs;
  var addPrice = ''.obs;
  var addAdditionalDetails = ''.obs;

  var isLoading = false.obs;

  late Stream<DocumentSnapshot> userDetailsStream;

  void listenToSalePropertyDetailsDataUpdates(String saleId) {
    try {
      print("ListenToSalePropertyDetailsDataUpdates....");

      userDetailsStream = FirebaseFirestore.instance
          .collection(
              AppConstants.collectionForSale) // Firestore collection name
          .doc(saleId) // Listen to document changes for the given HR ID
          .snapshots();

      userDetailsStream.listen((documentSnapshot) {
        if (documentSnapshot.exists) {
          // Update reactive variables with fetched data
          saleId = documentSnapshot['saleId'] ?? 'Unknown';
          addPropertyType.value =
              documentSnapshot['addPropertyType'] ?? 'Unknown';

          print("Property Type : ${addPropertyType.value}");

          addPostalCode.value = documentSnapshot['addPostalCode'] ?? 'Unknown';
          addUnit.value = documentSnapshot['addUnit'] ?? 'Unknown';
          addStreet.value = documentSnapshot['addStreet'] ?? 'Unknown';
          addTotalFloors.value =
              documentSnapshot['addTotalFloors'] ?? 'Unknown';
          addFloorNo.value = documentSnapshot['addFloorNo'] ?? 'Unknown';

          addSqft.value = documentSnapshot['addSqft'] ?? 'Unknown';
          addBhk.value = documentSnapshot['addBhk'] ?? 'Unknown';
          addBathrooms.value = documentSnapshot['addBathrooms'] ?? 'Unknown';
          addPrice.value = documentSnapshot['addPrice'] ?? 'Unknown';
          addAdditionalDetails.value =
              documentSnapshot['addAdditionalDetails'] ?? 'Unknown';

          print("Sale Property Details Fetched Successfully");
        } else {
          print("No Sale Property Details found for this ID");
        }
      });
    } catch (e) {
      print('Error listening to User data updates: $e');
    }
  }

  final addSaleCreatedAt =
      DateTime.now().obs; // Change to DateTime instead of String

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchSale();
    fetchRent();
  }

  final List<String> propertyTypeItemsForSale = [
    AppConstants.individualHouseForSale,
    AppConstants.flatsApartments,
  ];
  final List<String> propertyTypeItemsForRent = [
    AppConstants.individualHouseForRent,
    AppConstants.flatsApartments,
  ];

  RxList<SaleModel> saleList = <SaleModel>[].obs;
  RxList<RentModel> rentList = <RentModel>[].obs;

  var isSaleEditId = false.obs; // RxBool declaration

  RxString selectedPropertyType = ''.obs;

  var selectedIndex = 0.obs;
  void onTabChanged(int index) {
    selectedIndex.value = index;
  }

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

  final addAdvanceController = TextEditingController();
  final addRentController = TextEditingController();

  Future<void> addSaleProperty(BuildContext context) async {
    if (await addSalePropertyValidationFields(context)) {
      try {
        var currentDateTime = DateTime.now();
        var docRef =
            firebaseFirestore.collection(AppConstants.collectionForSale).doc();
        var saleId = docRef.id;

        var userId = UsersStorageService.getUserId();
        var userType = UsersStorageService.getUserType();
        var userName = UsersStorageService.getUserName();

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
            addAdditionalDetails: addAdditionalDetailsController.text.trim(),
            addSaleCreatedAt: currentDateTime,
            userId: userId,
            userType: userType.toString(),
            userName: userName.toString());

        await docRef.set(saleData.toMap());

        print("Add Sale : ${saleData.toString()}");
        Get.offNamed(AppRouter.AGENT_MAIN_SCREEN);
        buildScaffoldSuccessMessage(context, "Successfully Add Sale Details");

        clearController(context);
      } catch (e) {
        buildScaffoldErrorMessage(context, "fail to add Sale : $e");
      }
    }
  }

  addSalePropertyValidationFields(BuildContext context) {
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
      buildScaffoldErrorMessage(context, "Choose Property");
      return false;
    }
    if (addPostalCode.isEmpty) {
      buildScaffoldErrorMessage(context, "Enter Your Postal Code");
      return false;
    }
    if (addUnit.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Unit");
      return false;
    }
    if (addStreet.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Street");
      return false;
    }
    if (addFloorNo.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Total Floors");
      return false;
    }
    if (addTotalFloors.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Floor Number");
      return false;
    }
    if (addSqft.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Square Feet");
      return false;
    }
    if (addBhk.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  BHK");
      return false;
    }
    if (addBathrooms.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Bathrooms");
      return false;
    }

    if (addPrice.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Price");
      return false;
    }

    if (addAdditionalDetails.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Description");
      return false;
    }

    return true;
  }

  //----------------------add rent property

  Future<void> addRentProperty(BuildContext context) async {
    if (await addRentPropertyValidateField(context)) {
      try {
        var currentDateTime = DateTime.now();
        var docRef =
            firebaseFirestore.collection(AppConstants.collectionForRent).doc();
        var rentId = docRef.id;

        var userId = UsersStorageService.getUserId();
        var userType = UsersStorageService.getUserType();
        var userName = UsersStorageService.getUserName();

        var rentData = RentModel(
            rentId: rentId,
            addPropertyType: selectedPropertyType.value,
            addPostalCode: addPostalCodeController.text.trim(),
            addUnit: addUnitController.text.trim(),
            addStreet: addStreetController.text.trim(),
            addFloorNo: addFloorNoController.text.trim(),
            addSqft: addSqftController.text.trim(),
            addBhk: addBhkController.text.trim(),
            addBathrooms: addBathroomsController.text.trim(),
            addAdvance: addAdvanceController.text.trim(),
            addRent: addRentController.text.trim(),
            addAdditionalDetails: addAdditionalDetailsController.text.trim(),
            addRentCreatedAt: currentDateTime,
            userId: userId,
            userType: userType.toString(),
            userName: userName.toString());

        await docRef.set(rentData.toMap());

        print("Add Sale : ${rentData.toString()}");

        buildScaffoldSuccessMessage(context, "successfully Add Rent Details");

        clearController(context);
        fetchSale();
      } catch (e) {
        buildScaffoldErrorMessage(context, "failed to add Rent $e");
      }
    }
  }

  addRentPropertyValidateField(BuildContext context) {
    String addPropertyType = selectedPropertyType.value;
    String addPostalCode = addPostalCodeController.text.trim();
    String addUnit = addUnitController.text.trim();
    String addStreet = addStreetController.text.trim();
    String addFloorNo = addFloorNoController.text.trim();
    String addSqft = addSqftController.text.trim();
    String addBhk = addBhkController.text.trim();
    String addBathrooms = addBathroomsController.text.trim();
    String addAdvance = addAdvanceController.text.trim();
    String addRent = addRentController.text.trim();
    String addAdditionalDetails = addAdditionalDetailsController.text.trim();

    if (addPropertyType.isEmpty) {
      buildScaffoldErrorMessage(context, "Choose Property");
      return false;
    }
    if (addPostalCode.isEmpty) {
      buildScaffoldErrorMessage(context, "Enter Your Postal Code");
      return false;
    }
    if (addUnit.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Unit");
      return false;
    }
    if (addStreet.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Street");
      return false;
    }
    if (addFloorNo.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add Total Floors");
      return false;
    }

    if (addSqft.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Square Feet");
      return false;
    }
    if (addBhk.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  BHK");
      return false;
    }
    if (addBathrooms.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Bathrooms");
      return false;
    }
    if (addAdvance.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Advance Amount");
      return false;
    }
    if (addRent.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Rent Amount");
      return false;
    }

    if (addAdditionalDetails.isEmpty) {
      buildScaffoldErrorMessage(context, "Please Add  Description");
      return false;
    }

    return true;
  }

  Future<void> fetchSale() async {
    print("fetchSale started....");

    final userId = UsersStorageService.getUserId();
    print("userId $userId");

    try {
      isLoading.value = true;
      final snapshot = await firebaseFirestore
          .collection(AppConstants.collectionForSale)
          .where("userId", isEqualTo: userId)
          .orderBy('addSaleCreatedAt', descending: true)
          .get();

      saleList.value = snapshot.docs
          .map((doc) => SaleModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      isLoading.value = false;

      for (var sale in saleList.value) {
        print("FetchSale : $sale");

        addSaleCreatedAt.value = sale.addSaleCreatedAt;
        if (saleList.isNotEmpty) {
          print("Sales Data Fetched Successfully");
        }
      }
    } catch (e) {
      isLoading.value = false;
      print("Unable to fetch the details: $e");
    }
  }

  Future<void> fetchRent() async {
    print("fetchSale started....");

    final userId = UsersStorageService.getUserId();
    print("userId $userId");

    try {
      final snapshot = await firebaseFirestore
          .collection(AppConstants.collectionForRent)
          .where("userId", isEqualTo: userId)
          .orderBy('addRentCreatedAt', descending: true)
          .get();

      rentList.value = snapshot.docs
          .map((doc) => RentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      for (var sale in rentList.value) {
        print("FetchSale : $sale");
      }
    } catch (e) {
      print("Unable to fetch the details: $e");
    }
  }

  void clearController(BuildContext context) {
    isSaleEditId.value = false;
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

    addAdvanceController.clear();
    addRentController.clear();
  }

  void deleteSaleData(BuildContext context, String saleId) async {
    try {
      // Delete the document with the given saleId
      await firebaseFirestore
          .collection(AppConstants.collectionForSale)
          .doc(saleId)
          .delete();

      // Notify success
      buildScaffoldSuccessMessage(context, "Sale Data successfully Deleted");

      clearController(context);
      Get.toNamed(AppRouter.AGENT_MAIN_SCREEN);
      fetchSale();
    } catch (e) {
      // Handle errors
      buildScaffoldErrorMessage(context, "Failed to delete sale data: $e");
    }
  }
}
