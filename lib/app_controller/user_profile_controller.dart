import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

import '../storage_services/users_storage_service.dart';

class UserProfileController extends GetxController {
  var authId = ''.obs;
  var authName = ''.obs;
  var authMobileNumber = ''.obs;
  var authEmailAddress = ''.obs;
  var authPassword = ''.obs;
  var authConfirmPassword = ''.obs;
  var authAs = ''.obs;

  late Stream<DocumentSnapshot> userDataStream;

  void listenToUserProfileDataUpdates() {
    try {
      print("ListenToUserProfileDataUpdates....");

      final userId = UsersStorageService.getUserId();

      userDataStream = FirebaseFirestore.instance
          .collection(AppConstants.collectionAuth) // Firestore collection name
          .doc(userId) // Listen to document changes for the given HR ID
          .snapshots();

      userDataStream.listen((documentSnapshot) {
        if (documentSnapshot.exists) {
          // Update reactive variables with fetched data
          authId.value = documentSnapshot['authId'] ?? 'Unknown';
          authName.value = documentSnapshot['authName'] ?? 'Unknown';

          print("AuthName : ${authName.value}");

          authMobileNumber.value =
              documentSnapshot['authMobileNumber'] ?? 'Unknown';
          authEmailAddress.value =
              documentSnapshot['authEmailAddress'] ?? 'Unknown';
          authPassword.value = documentSnapshot['authPassword'] ?? 'Unknown';
          authConfirmPassword.value =
              documentSnapshot['authConfirmPassword'] ?? 'Unknown';
          authAs.value = documentSnapshot['authAs'] ?? 'Unknown';

          print("User Profile Fetched Successfully");
        } else {
          print("No User data found for this ID");
        }
      });
    } catch (e) {
      print('Error listening to User data updates: $e');
    }
  }
}
