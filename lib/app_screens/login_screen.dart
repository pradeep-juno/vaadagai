import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: buildTextFun(
        context,
        "welcome to login page",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        buttonpress: true,
        onTap: () => Get.offNamed(AppRouter.REGISTER_SCREEN),
      )),
    );
  }
}
