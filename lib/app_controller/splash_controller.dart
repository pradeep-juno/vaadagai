import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offNamed(AppRouter.GETSTARTED_SCREEN);
  }
}
