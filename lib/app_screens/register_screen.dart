import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_colors.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

import '../app_controller/auth_controller.dart';
import '../app_utils/app_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 120,
              child: buildCustomScrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSizedBoxHeightFun(context, height: 30),
                      buildAuthHeaderFun(context, AppConstants.registerCaps),
                      buildSizedBoxHeightFun(context, height: 30),
                      buildRegisterBodyFun(context, authController),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 60,
              right: 60,
              child: buildRegisterButtonFun(context, authController),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCustomScrollbar({
  required Widget child,
  bool thumbVisibility = true,
  double thickness = 4.0,
  Radius radius = const Radius.circular(5),
}) {
  return Scrollbar(
    thumbVisibility: thumbVisibility,
    thickness: thickness,
    radius: radius,
    child: child,
  );
}

buildRegisterButtonFun(BuildContext context, AuthController authController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildContainerButtonFun(context, AppConstants.registerSmall,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.orange, onPressed: () {
          print('Register button clicked!');
          authController.register(context);
        }),
        buildSizedBoxHeightFun(context, height: 5),
        buildTextFun(
          context,
          AppConstants.alreadyHaveAccountLogin,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          buttonpress: true, // This will make the text clickable
          onTap: () {
            print('Text clicked!');
            Get.offNamed(AppRouter.LOGIN_SCREEN);
          },
        )
      ],
    ),
  );
}

buildRegisterBodyFun(BuildContext context, AuthController authController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        buildTextFormFieldFun(
          context: context,
          text: AppConstants.name,
          hintText: AppConstants.enterYourName,
          controller: authController.authNameController,
          isSmallSize: false,
        ),
        buildSizedBoxHeightFun(context, height: 20),
        buildTextFormFieldFun(
          context: context,
          text: AppConstants.mobileNumber,
          hintText: AppConstants.enterTenDigitNumber,
          controller: authController.authMobileNumberController,
          keyboardType: TextInputType.phone,
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          isSmallSize: false,
        ),
        buildSizedBoxHeightFun(context, height: 20),
        buildTextFormFieldFun(
          context: context,
          text: AppConstants.emailAddress,
          hintText: AppConstants.enterEmailId,
          controller: authController.authEmailAddressController,
          keyboardType: TextInputType.emailAddress,
          isSmallSize: false,
        ),
        buildSizedBoxHeightFun(context, height: 20),
        buildTextFormFieldFun(
            context: context,
            text: AppConstants.password,
            hintText: AppConstants.enterYourPassword,
            controller: authController.authPasswordController,
            isPassword: true,
            isSmallSize: false,
            inputFormatters: [LengthLimitingTextInputFormatter(8)]),
        buildSizedBoxHeightFun(context, height: 20),
        buildTextFormFieldFun(
            context: context,
            text: AppConstants.confirmPassword,
            hintText: AppConstants.confirmPassword,
            controller: authController.authConfirmPasswordController,
            isPassword: true,
            isSmallSize: false,
            inputFormatters: [LengthLimitingTextInputFormatter(8)]),
        buildSizedBoxHeightFun(context, height: 20),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTextFun(
                  context,
                  AppConstants.registerAs,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                buildSizedBoxWidthFun(context, width: 20),
                buildTextFun(
                  context,
                  AppConstants.buyer,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                Radio<String>(
                  value: AppConstants.buyer,
                  groupValue: authController.radioButton.value,
                  onChanged: (value) {
                    authController.radioButton.value = value!;
                    print("Selected: ${AppConstants.buyer}");
                  },
                  activeColor: AppColors.orange,
                ),
                buildSizedBoxWidthFun(context, width: 8),
                buildTextFun(
                  context,
                  AppConstants.agent,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                Radio<String>(
                  value: AppConstants.agent,
                  groupValue: authController.radioButton.value,
                  onChanged: (value) {
                    authController.radioButton.value = value!;
                    print("Selected: ${AppConstants.agent}");
                  },
                  activeColor: AppColors.orange,
                ),
              ],
            )),
      ],
    ),
  );
}
