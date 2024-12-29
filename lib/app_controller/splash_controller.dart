import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';

class SplashController extends GetxController {



  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offNamed(AppRouter.GETSTARTED_SCREEN); // Navigate to the home screen
  }
}
