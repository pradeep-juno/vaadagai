import 'package:get/get.dart';
import 'package:vaadagai/app_screens/login_screen.dart';
import 'package:vaadagai/app_screens/register_screen.dart';
import 'package:vaadagai/app_screens/splash_screen.dart';

import '../app_screens/get_started_screen.dart';

class AppRouter {
  static const SPLASH_SCREEN = '/splash-screen';
  static const GETSTARTED_SCREEN = '/get-started-screen';
  static const REGISTER_SCREEN = '/register-screen';
  static const LOGIN_SCREEN = '/login-screen';

  static var routes = [
    GetPage(
      name: SPLASH_SCREEN,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: GETSTARTED_SCREEN,
      page: () => const GetStartedScreen(),
    ),
    GetPage(
      name: REGISTER_SCREEN,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: LOGIN_SCREEN,
      page: () => const LoginScreen(),
    ),
  ];
}
