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
          buildScaffoldSuccessMessage(context, "Registered successfully");
          clearController();
          Get.offNamed(AppRouter.ONBOARD_VIEW);

          //save locally
        } else {
          isLoading.value = false;
          buildScaffoldErrorMessage(context, "User creation failed.");
        }
      } catch (e) {
        isLoading.value = false;
        buildScaffoldErrorMessage(context, 'Failed to register: $e');
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
      buildScaffoldErrorMessage(context, 'Please enter Name');
      return false;
    }
    if (authMobileNumber.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Mobile Number');
      return false;
    } else if (authMobileNumber.length < 10) {
      buildScaffoldErrorMessage(
          context, 'Invalid mobile number, must be at least 10 digits');
      return false;
    } else if (await isFieldExist('authMobileNumber', authMobileNumber)) {
      buildScaffoldErrorMessage(context, 'Mobile number already Register');
      return false;
    }

    if (authEmailAddress.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Email Address');
      return false;
    } else {
      // Using EmailValidator to check general email format
      if (!EmailValidator.validate(authEmailAddress)) {
        buildScaffoldErrorMessage(
            context, 'Please enter a valid Email Address');
        return false;
      } else {
        // Additional check for Gmail domain
        if (!authEmailAddress.endsWith('@gmail.com')) {
          buildScaffoldErrorMessage(
              context, 'Please enter a valid Gmail address (e.g., @gmail.com)');
          return false;
        } else if (await isFieldExist('authEmailAddress', authEmailAddress)) {
          buildScaffoldErrorMessage(
              context, 'Email address already Registered');
          return false;
        }
      }
    }

    if (authPassword.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Password');
      return false;
    } else if (authPassword.length < 4) {
      buildScaffoldErrorMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (authConfirmPassword.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Confirm Password');
      return false;
    } else if (authConfirmPassword.length < 4) {
      buildScaffoldErrorMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (authPassword != authConfirmPassword) {
      buildScaffoldErrorMessage(
          context, 'Password and Confirm Password does not match');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please select (Buyer or Agent)');
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
        buildScaffoldErrorMessage(context, 'Email or Password cannot be empty');
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
              String authEmailAddress =
                  userData['authEmailAddress'] ?? 'Unknown';
              String authPassword = userData['authPassword'] ?? 'Unknown';

              print("authAsLoginScreen : $authAs");
              print("authMobileNumber : $authMobileNumber");

              isLoading.value = false;

              // Navigate based on the authAs value
              if ((radioButton.value == AppConstants.agent) &&
                  (authAs == AppConstants.agent)) {
                buildScaffoldSuccessMessage(
                    context, 'Login Successful, Welcome $authName!');

                UsersStorageService.saveUser(
                  user.uid,
                  authName,
                  authMobileNumber,
                  authEmailAddress,
                  authPassword,
                  authAs,
                );

                /*
                 UsersStorageService.saveUser(
              user.uid,
              authNameController.text.trim(),
              authMobileNumberController.text.trim(),
              authEmailAddressController.text.trim(),
              authPasswordController.text.trim(),
              radioButton.value);
                 */

                Get.offNamed(AppRouter.AGENT_MAIN_SCREEN);
              } else if ((radioButton.value == AppConstants.buyer) &&
                  (authAs == AppConstants.buyer)) {
                buildScaffoldSuccessMessage(
                    context, 'Login Successful, Welcome $authName!');
                Get.offNamed(AppRouter.BUYER_MAIN_SCREEN);
              } else {
                buildScaffoldErrorMessage(context, 'Invalid user type');
              }
            } else {
              isLoading.value = false;
              buildScaffoldErrorMessage(
                  context, 'User data is incomplete. Please contact support.');
            }
          } else {
            isLoading.value = false;
            buildScaffoldErrorMessage(
                context, 'No user data found in Database. Please register.');
          }
        } else {
          isLoading.value = false;
          buildScaffoldErrorMessage(
              context, 'Authentication failed. Try again.');
        }
      } catch (e) {
        isLoading.value = false;
        String errorMessage = getErrorMessage(e);
        buildScaffoldErrorMessage(context, errorMessage);
      }
    }
  }

  loginValidateFields(BuildContext context) async {
    String authEmailAddress = authEmailAddressController.text.trim();
    String authPassword = authPasswordController.text.trim();

    if (authEmailAddress.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Email Address');
      return false;
    } else {
      // Using EmailValidator to check general email format
      if (!EmailValidator.validate(authEmailAddress)) {
        buildScaffoldErrorMessage(
            context, 'Please enter a valid Email Address');
        return false;
      } else {
        // Additional check for Gmail domain
        if (!authEmailAddress.endsWith('@gmail.com')) {
          buildScaffoldErrorMessage(
              context, 'Please enter a valid Gmail address (e.g., @gmail.com)');
          return false;
        }
      }
    }
    if (authPassword.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please enter Password');
      return false;
    } else if (authPassword.length < 4) {
      buildScaffoldErrorMessage(context, 'Password atleast min 4 letters');
      return false;
    }

    if (radioButton.value.isEmpty) {
      buildScaffoldErrorMessage(context, 'Please select (Buyer or agent)');
      return false;
    }
    return true;
  }

  Future<void> deleteAccount(BuildContext context) async {
    UsersStorageService.getPassword().toString();
    // Show confirmation dialog before deleting the account
    Get.defaultDialog(
      title: AppConstants.deleteAccountTitle,
      middleText: AppConstants.deleteAccountConfirmationMessage,
      textCancel: AppConstants.cancel,
      textConfirm: AppConstants.confirm,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          isLoading.value = true;

          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            String userId = currentUser.uid;

            // Reauthenticate the user before deletion
            AuthCredential credential = EmailAuthProvider.credential(
              email: currentUser.email!,
              password: UsersStorageService.getPassword()
                  .toString(), // Get password securely stored during login
            );

            // Reauthenticate the user
            await currentUser.reauthenticateWithCredential(credential);

            // Delete user from Firebase Authentication first
            await currentUser.delete();

            // After successful deletion from Firebase Auth, delete the user data from Firestore
            await FirebaseFirestore.instance
                .collection(AppConstants.collectionAuth)
                .doc(userId)
                .delete();

            // Clear locally stored user data
            UsersStorageService.clearUserData();

            isLoading.value = false;
            buildScaffoldSuccessMessage(
                context, AppConstants.accountDeletedSuccess);

            // Navigate to onboarding or login screen
            Get.offAllNamed(AppRouter.LOGIN_SCREEN);
          } else {
            isLoading.value = false;
            buildScaffoldErrorMessage(context, AppConstants.noUserToDelete);
          }
        } catch (e) {
          isLoading.value = false;
          buildScaffoldErrorMessage(
              context, '${AppConstants.failedToDeleteAccount} $e');
        }
      },
      onCancel: () {
        Get.back(); // Close the dialog without deleting
      },
    );
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
