import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

import '../app_model/auth_model.dart';

class AuthController extends GetxController {
  RxString radioButton = ''.obs; //radio button excecution

  void clearRadioButton() {
    radioButton.value = ''; // Reset radio button value
  }

  FirebaseFirestore firebaseFirestore =
      FirebaseFirestore.instance; //initialize firbase

  //initialize controller to access all the fields
  final authNameController = TextEditingController();
  final authMobileNumberController = TextEditingController();
  final authEmailAddressController = TextEditingController();
  final authPasswordController = TextEditingController();
  final authConfirmPasswordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    if (await validateFields(context)) {
      try {
        var docRef =
            firebaseFirestore.collection(AppConstants.collectionAuth).doc();
        var authId = docRef.id;
        var authData = AuthModel(
            authId: authId,
            authName: authNameController.text.trim(),
            authMobileNumber: authMobileNumberController.text.trim(),
            authEmailAddress: authEmailAddressController.text.trim(),
            authPassword: authPasswordController.text.trim(),
            authConfirmPassword: authConfirmPasswordController.text.trim(),
            authAs: radioButton.value);

        await docRef.set(authData.toMap());

        print(authData.toString());

        buildScaffoldMessage(context, " Register successfully ");
        clearController();
        Get.offNamed(AppRouter.LOGIN_SCREEN);
      } catch (e) {
        buildScaffoldMessage(context, 'Fail to  because $e');
      }
    }
  }

  validateFields(BuildContext context) async {
    String authName = authNameController.text.trim();
    String authMobileNumber = authMobileNumberController.text.trim();
    String authEmailAddress = authEmailAddressController.text.trim();
    String authPassword = authPasswordController.text.trim();
    String authConfirmPassword = authConfirmPasswordController.text.trim();

    if (authName.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Name');
      return false;
    }
    if (authMobileNumber.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Mobile Number');
      return false;
    } else if (authMobileNumber.length < 10) {
      buildScaffoldMessage(
          context, 'Invalid mobile number, must be at least 10 digits');
      return false;
    } else if (await isFieldExist('authMobileNumber', authMobileNumber)) {
      buildScaffoldMessage(context, 'Mobile number already Register');
      return false;
    }

    if (authEmailAddress.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Email Address');
      return false;
    } else {
      // Using EmailValidator to check general email format
      if (!EmailValidator.validate(authEmailAddress)) {
        buildScaffoldMessage(context, 'Please enter a valid Email Address');
        return false;
      } else {
        // Additional check for Gmail domain
        if (!authEmailAddress.endsWith('@gmail.com')) {
          buildScaffoldMessage(
              context, 'Please enter a valid Gmail address (e.g., @gmail.com)');
          return false;
        } else if (await isFieldExist('authEmailAddress', authEmailAddress)) {
          buildScaffoldMessage(context, 'Email address already Registered');
          return false;
        }
      }
    }

    if (authPassword.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Password');
      return false;
    } else if (authPassword.length < 4) {
      buildScaffoldMessage(context, 'Password atleast min 4 letters');
      return false;
    } else if (await isFieldExist('authPassword', authPassword)) {
      buildScaffoldMessage(context, 'Password already Registered');
      return false;
    }

    if (authConfirmPassword.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Confirm Password');
      return false;
    } else if (authConfirmPassword.length < 4) {
      buildScaffoldMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (authPassword != authConfirmPassword) {
      buildScaffoldMessage(
          context, 'Password and Confirm Password do not match');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldMessage(context, 'Please select (Buyer or agent)');
      return false;
    }
    return true;
  }

  void clearController() {
    authNameController.clear();
    authMobileNumberController.clear();
    authEmailAddressController.clear();
    authPasswordController.clear();
    authConfirmPasswordController.clear();
    clearRadioButton();
  }

  //---Checks if a specific field with a given value exists in the Firestore collection.---//
  Future<bool> isFieldExist(String fieldName, String fieldValue) async {
    var querySnapshot = await firebaseFirestore
        .collection(AppConstants.collectionAuth)
        .where(fieldName, isEqualTo: fieldValue)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
