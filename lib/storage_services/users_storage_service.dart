import 'package:get_storage/get_storage.dart';

class UsersStorageService {
  static final box = GetStorage();
  //Users
  static const String userIDKey = 'user_id';
  static const String userNameKey = 'user_id';
  static const String userMobileNumberKey = 'user_id';
  static const String userEmailKey = 'user_id';
  static const String userPasswordKey = 'user_id';
  static const String userTypeKey = 'user_id';

  static saveUser(String userId, String userName, String userMobileNumber,
      String userEmail, String userPasswordKey, String userType) async {
    try {
      print('Saving User Data');
      await box.write(userIDKey, userId);
      await box.write(userNameKey, userName);
      await box.write(userMobileNumberKey, userMobileNumber);
      await box.write(userEmailKey, userEmail);
      await box.write(userPasswordKey, userPasswordKey);
      await box.write(userTypeKey, userType);
      print('User Data saved successfully');

      print("User Id $userId");
      print("User Name : $userName");
      print("User Mobile Number : $userMobileNumber");
      print("User Email : $userEmail");
      print("User Password : $userPasswordKey");
      print("User Type : $userType");
    } catch (e) {
      print('Error saving User Data: $e');
    }
  }

  static String? getUserId() {
    try {
      String? userId = box.read(userIDKey);
      print('Getting UserId: $userId');
      return userId;
    } catch (e) {
      print('Error getting UserId: $e');
      return null;
    }
  }

  static String? getUserType() {
    try {
      String? userId = box.read(userTypeKey);
      print('Getting UserType: $userId');
      return userId;
    } catch (e) {
      print('Error getting UserType: $e');
      return null;
    }
  }

  static clearUserData() async {
    try {
      print("UserId: ${userIDKey}");

      // Remove all event manager keys
      await box.remove(userNameKey);
      await box.remove(userMobileNumberKey);
      await box.remove(userEmailKey);
      await box.remove(userPasswordKey);
      await box.remove(userIDKey);
      await box.remove(userTypeKey);

      print('User Data cleared successfully');
    } catch (e) {
      print('Error clearing User Data: $e');
    }
  }
}
