import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_model/register_model.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

class RegisterController extends GetxController {
  RxString radioButton = ''.obs; //radio button excecution

  void clearRadioButton() {
    radioButton.value = ''; // Reset radio button value
  }

  FirebaseFirestore firebaseFirestore =
      FirebaseFirestore.instance; //initialize firbase

  //initialize controller to access all the fields
  final regNameController = TextEditingController();
  final regMobileNumberController = TextEditingController();
  final regEmailAddressController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regConfirmPasswordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    if (await validateFields(context)) {
      try {
        var docRef =
            firebaseFirestore.collection(AppConstants.collectionRegister).doc();
        var regId = docRef.id;
        var regData = RegisterModel(
            regId: regId,
            regName: regNameController.text.trim(),
            regMobileNumber: regMobileNumberController.text.trim(),
            regEmailAddress: regEmailAddressController.text.trim(),
            regPassword: regPasswordController.text.trim(),
            regConfirmPassword: regConfirmPasswordController.text.trim(),
            regAs: radioButton.value);

        await docRef.set(regData.toMap());

        print(regData.toString());

        buildScaffoldMessage(context, "Register successfully ");
        clearController();
        Get.offNamed(AppRouter.LOGIN_SCREEN);
      } catch (e) {
        buildScaffoldMessage(context, 'Fail to register because $e');
      }
    }
  }

  validateFields(BuildContext context) async {
    String regName = regNameController.text.trim();
    String regMobileNumber = regMobileNumberController.text.trim();
    String regEmailAddress = regEmailAddressController.text.trim();
    String regPassword = regPasswordController.text.trim();
    String regConfirmPassword = regConfirmPasswordController.text.trim();

    if (regName.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Name');
      return false;
    } else if (await isFieldExist('regName', regName)) {
      buildScaffoldMessage(context, 'Name already registered');
      return false;
    }

    if (regMobileNumber.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Mobile Number');
      return false;
    } else if (regMobileNumber.length < 10) {
      buildScaffoldMessage(
          context, 'Invalid mobile number, must be at least 10 digits');
      return false;
    } else if (await isFieldExist('regMobileNumber', regMobileNumber)) {
      buildScaffoldMessage(context, 'Mobile number already registered');
      return false;
    }

    if (regEmailAddress.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Email Address');
      return false;
    } else {
      if (!EmailValidator.validate(regEmailAddress)) {
        buildScaffoldMessage(context, 'Please enter a valid Email Address');
        return false;
      } else if (await isFieldExist('regEmailAddress', regEmailAddress)) {
        buildScaffoldMessage(context, 'Email address already registered');
        return false;
      }
    }
    if (regPassword.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Password');
      return false;
    } else if (regPassword.length < 4) {
      buildScaffoldMessage(context, 'Password atleast min 4 letters');
      return false;
    } else if (await isFieldExist('regPassword', regPassword)) {
      buildScaffoldMessage(context, 'Password already registered');
      return false;
    }

    if (regConfirmPassword.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Confirm Password');
      return false;
    } else if (regConfirmPassword.length < 4) {
      buildScaffoldMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (regPassword != regConfirmPassword) {
      buildScaffoldMessage(
          context, 'Password and Confirm Password do not match');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldMessage(context, 'Please select a regAs (Buyer or Seller)');
      return false;
    }
    return true;
  }

  void clearController() {
    regNameController.clear();
    regMobileNumberController.clear();
    regEmailAddressController.clear();
    regPasswordController.clear();
    regConfirmPasswordController.clear();
    clearRadioButton();
  }

  //---Checks if a specific field with a given value exists in the Firestore collection.---//
  Future<bool> isFieldExist(String fieldName, String fieldValue) async {
    var querySnapshot = await firebaseFirestore
        .collection(AppConstants.collectionRegister)
        .where(fieldName, isEqualTo: fieldValue)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
