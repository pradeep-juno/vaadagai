import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/splash_controller.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.network(
            AppConstants.vaadagaiLogoUrl,
            height: 150, // Replace with your image URL
            width: 150,
          ),
        ),
      ),
    );
  }
}
