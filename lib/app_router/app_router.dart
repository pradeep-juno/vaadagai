import 'package:get/get.dart';
import 'package:vaadagai/app_screens/agent/add_property/agent_add_rent_screen.dart';
import 'package:vaadagai/app_screens/agent/add_property/agent_add_sale_screen.dart';
import 'package:vaadagai/app_screens/agent/add_property/agent_rent_detail_screen.dart';
import 'package:vaadagai/app_screens/agent/add_property/property_add_screen.dart';
import 'package:vaadagai/app_screens/app_nav_bar/agent_main_screen.dart';
import 'package:vaadagai/app_screens/app_nav_bar/agent_more_screen.dart';
import 'package:vaadagai/app_screens/buyer/buyer_main_screen.dart';
import 'package:vaadagai/app_screens/login_screen.dart';
import 'package:vaadagai/app_screens/onboard_screen/onboard_screen_three.dart';
import 'package:vaadagai/app_screens/register_screen.dart';
import 'package:vaadagai/app_screens/splash_screen.dart';

import '../app_screens/agent/add_property/agent_sale_detail_screen.dart';
import '../app_screens/get_started_screen.dart';
import '../app_screens/onboard_screen/onboard_screen_one.dart';
import '../app_screens/onboard_screen/onboard_screen_two.dart';
import '../app_screens/onboard_screen/onboard_view.dart';
import '../app_screens/profile_screen/agent_profile_screen.dart';

class AppRouter {
  static const SPLASH_SCREEN = '/splash-screen';
  static const GETSTARTED_SCREEN = '/get-started-screen';
  static const REGISTER_SCREEN = '/register-screen';
  static const LOGIN_SCREEN = '/login-screen';
  static const AGENT_MAIN_SCREEN = '/agent-home-screen';
  static const AGENT_MORE_SCREEN = '/agent-more-screen';
  static const ONBOARD_VIEW = '/onboard-screen-view';
  static const ONBOARD_SCREEN_ONE = '/onboard-screen-one';
  static const ONBOARD_SCREEN_TWO = '/onboard-screen-two';
  static const ONBOARD_SCREEN_THREE = '/onboard-screen-three';
  static const PROPERTY_ADD_SCREEN = '/property-add-screen';
  static const AGENT_ADD_SALE_SCREEN = '/agent-add-sale-screen';
  static const AGENT_ADD_RENT_SCREEN = '/agent-add-rent-screen';
  static const AGENT_PROFILE_SCREEN = '/agent-profile-screen';

  static const AGENT_SALE_DETAIL_SCREEN = '/agent-sale-detail-screen';
  static const AGENT_RENT_DETAIL_SCREEN = '/agent-rent-detail-screen';
  //buyer

  static const BUYER_MAIN_SCREEN = '/buyer-main-screen';

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
    GetPage(
      name: AGENT_MAIN_SCREEN,
      page: () => AgentMainScreen(),
    ),
    GetPage(
      name: ONBOARD_SCREEN_ONE,
      page: () => OnboardScreenOne(),
    ),
    GetPage(
      name: ONBOARD_SCREEN_TWO,
      page: () => OnboardScreenTwo(),
    ),
    GetPage(
      name: ONBOARD_SCREEN_THREE,
      page: () => OnboardScreenThree(),
    ),
    GetPage(
      name: ONBOARD_VIEW,
      page: () => OnboardView(),
    ),
    GetPage(
      name: PROPERTY_ADD_SCREEN,
      page: () => PropertyAddScreen(),
    ),
    GetPage(
      name: AGENT_ADD_SALE_SCREEN,
      page: () => AgentAddSaleScreen(),
    ),
    GetPage(
      name: AGENT_ADD_RENT_SCREEN,
      page: () => AgentAddRentScreen(),
    ),
    GetPage(
      name: BUYER_MAIN_SCREEN,
      page: () => BuyerMainScreen(),
    ),
    GetPage(
      name: AGENT_MORE_SCREEN,
      page: () => AgentMoreScreen(),
    ),
    GetPage(
      name: AGENT_PROFILE_SCREEN,
      page: () => AgentProfileScreen(),
    ),
    GetPage(
      name: AGENT_SALE_DETAIL_SCREEN,
      page: () => AgentSaleDetailScreen(),
    ),
    GetPage(
      name: AGENT_RENT_DETAIL_SCREEN,
      page: () => AgentRentDetailScreen(),
    ),
  ];
}
