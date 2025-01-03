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
          body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildAuthHeaderFun(context, AppConstants.loginCaps),
                      buildSizedBoxHeightFun(context, height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: authController.authKey,
                          child: Column(
                            children: [
                              buildLoginBodyFun(context, authController),
                              buildSizedBoxHeightFun(context, height: 20),
                              buildLoginButtonFun(context, authController),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() {
              return authController.isLoading.value
                  ? loadingProgress(context)
                  : const SizedBox.shrink();
            }),
          )
        ],
      )),
    );
  }
}
