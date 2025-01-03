import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';
import 'package:vaadagai/storage_services/users_storage_service.dart';

import '../app_model/auth_model.dart';

class AuthController extends GetxController {
  RxString radioButton = ''.obs; //radio button excecution

  final authKey = GlobalKey<FormState>();

  void clearRadioButton() {
    radioButton.value = ''; // Reset radio button value
  }

  FirebaseFirestore firebaseFirestore =
      FirebaseFirestore.instance; //initialize firbase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //initialize controller to access all the fields
  final authNameController = TextEditingController();
  final authMobileNumberController = TextEditingController();
  final authEmailAddressController = TextEditingController();
  final authPasswordController = TextEditingController();
  final authConfirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> register(BuildContext context) async {
    if (await registerValidateFields(context)) {
      try {
        isLoading.value = true;

        // Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authEmailAddressController.text.trim(),
          password: authPasswordController.text.trim(),
        );

        User? user = userCredential.user;
        if (user != null) {
          // Store user details in Firestore
          var docRef = FirebaseFirestore.instance
              .collection(AppConstants.collectionAuth)
              .doc(user.uid);

          var authData = AuthModel(
            authId: user.uid,
            authName: authNameController.text.trim(),
            authMobileNumber: authMobileNumberController.text.trim(),
            authEmailAddress: user.email!,
            authPassword: authPasswordController.text.trim(),
            authConfirmPassword: authConfirmPasswordController.text.trim(),
            authAs: radioButton.value,
          );

          await docRef.set(authData.toMap());

          print("auth Reg User : ${authData.toString()}");

          UsersStorageService.saveUser(
              user.uid,
              authNameController.text.trim(),
              authMobileNumberController.text.trim(),
              authEmailAddressController.text.trim(),
              authPasswordController.text.trim(),
              radioButton.value);

          isLoading.value = false;
          // Show success message and navigate to login screen
          buildScaffoldMessage(context, "Registered successfully");
          clearController();
          Get.offNamed(AppRouter.ONBOARD_VIEW);

          //save locally
        } else {
          isLoading.value = false;
          buildScaffoldMessage(context, "User creation failed.");
        }
      } catch (e) {
        isLoading.value = false;
        buildScaffoldMessage(context, 'Failed to register: $e');
      }
    }
  }

  registerValidateFields(BuildContext context) async {
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
          context, 'Password and Confirm Password does not match');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldMessage(context, 'Please select (Buyer or Agent)');
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

  //----------------this is method for login-------------------------//

  Future<void> login(BuildContext context) async {
    if (await loginValidateFields(context)) {
      isLoading.value = true;

      String authEmailAddress = authEmailAddressController.text.trim();
      String authPassword = authPasswordController.text.trim();

      if (authEmailAddress.isEmpty || authPassword.isEmpty) {
        buildScaffoldMessage(context, 'Email or Password cannot be empty');
        isLoading.value = false;
        return;
      }

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authEmailAddress,
          password: authPassword,
        );

        User? user = userCredential.user;
        if (user != null) {
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              await FirebaseFirestore.instance
                  .collection(AppConstants.collectionAuth)
                  .doc(user.uid)
                  .get();

          if (userDoc.exists) {
            Map<String, dynamic>? userData = userDoc.data();

            if (userData != null) {
              String authAs = userData['authAs'] ?? 'User';
              String authName = userData['authName'] ?? 'User';
              String authMobileNumber =
                  userData['authMobileNumber'] ?? 'Unknown';

              print("authAs : $authAs");
              print("authMobileNumber : $authMobileNumber");

              isLoading.value = false;

              // Navigate based on the authAs value
              if ((radioButton.value == AppConstants.agent) &&
                  (authAs == AppConstants.agent)) {
                buildScaffoldMessage(
                    context, 'Login Successful, Welcome $authName!');
                Get.offNamed(AppRouter.ONBOARD_VIEW);
              } else if ((radioButton.value == AppConstants.buyer) &&
                  (authAs == AppConstants.buyer)) {
                buildScaffoldMessage(
                    context, 'Login Successful, Welcome $authName!');
                Get.offNamed(AppRouter.BUYER_MAIN_SCREEN);
              } else {
                buildScaffoldMessage(context, 'Invalid user type');
              }
            } else {
              isLoading.value = false;
              buildScaffoldMessage(
                  context, 'User data is incomplete. Please contact support.');
            }
          } else {
            isLoading.value = false;
            buildScaffoldMessage(
                context, 'No user data found in Database. Please register.');
          }
        } else {
          isLoading.value = false;
          buildScaffoldMessage(context, 'Authentication failed. Try again.');
        }
      } catch (e) {
        isLoading.value = false;
        String errorMessage = getErrorMessage(e);
        buildScaffoldMessage(context, errorMessage);
      }
    }
  }

  // Future<void> login(BuildContext context) async {
  //   if (await loginValidateFields(context)) {
  //     isLoading.value = true;
  //
  //     String authEmailAddress = authEmailAddressController.text.trim();
  //     String authPassword = authPasswordController.text.trim();
  //
  //     // Check for empty credentials
  //     if (authEmailAddress.isEmpty || authPassword.isEmpty) {
  //       buildScaffoldMessage(context, 'Email or Password cannot be empty');
  //       return;
  //     }
  //
  //     try {
  //       // Perform Firebase authentication
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: authEmailAddress,
  //         password: authPassword,
  //       );
  //
  //       User? user = userCredential.user;
  //       if (user != null) {
  //         // Retrieve additional details from Firestore
  //         DocumentSnapshot<Map<String, dynamic>> userDoc =
  //             await FirebaseFirestore.instance
  //                 .collection(AppConstants.collectionAuth)
  //                 .doc(user.uid)
  //                 .get();
  //
  //         if (userDoc.exists) {
  //           // Check additional user data if needed
  //           Map<String, dynamic>? userData = userDoc.data();
  //
  //           String authAs = userData?['authAs'] ?? 'User';
  //           String authMobileNumber = userData?['authMobileNumber'] ?? 'User';
  //
  //           print("authAs : $authAs");
  //           print("authMobileNumber : $authMobileNumber");
  //
  //           if (userData != null) {
  //             // Successful login and data retrieval
  //             isLoading.value = false;
  //
  //             buildScaffoldMessage(context,
  //                 'Login Successful, Welcome ${userData['authName']}!');
  //             // Navigate to the next screen
  //             Get.offNamed(AppRouter
  //                 .ONBOARD_VIEW); // Replace '/home' with your desired route
  //           } else {
  //             isLoading.value = false;
  //             buildScaffoldMessage(
  //                 context, 'User data is incomplete. Please contact support.');
  //           }
  //         } else {
  //           isLoading.value = false;
  //           buildScaffoldMessage(
  //               context, 'No user data found in Database. Please register.');
  //         }
  //       } else {
  //         isLoading.value = false;
  //         buildScaffoldMessage(context, 'Authentication failed. Try again.');
  //       }
  //     } catch (e) {
  //       isLoading.value = false;
  //       // Handle errors and display appropriate messages
  //       String errorMessage = getErrorMessage(e);
  //       buildScaffoldMessage(context, errorMessage);
  //     }
  //   }
  // }

  loginValidateFields(BuildContext context) async {
    String authEmailAddress = authEmailAddressController.text.trim();
    String authPassword = authPasswordController.text.trim();

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
        }
      }
    }
    if (authPassword.isEmpty) {
      buildScaffoldMessage(context, 'Please enter Password');
      return false;
    } else if (authPassword.length < 4) {
      buildScaffoldMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldMessage(context, 'Please select (Buyer or agent)');
      return false;
    }
    return true;
  }
}

String getErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Invalid password. Please try again.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
  return 'An unexpected error occurred.';
}
