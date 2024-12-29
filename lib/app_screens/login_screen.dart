import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/auth_controller.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSizedBoxHeightFun(context, height: 40),
              buildAuthHeaderFun(context, AppConstants.loginCaps),
              buildSizedBoxHeightFun(context, height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    buildLoginBodyFun(context, authController),
                    buildSizedBoxHeightFun(context, height: 20),
                    buildLoginButtonFun(context, authController),
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
