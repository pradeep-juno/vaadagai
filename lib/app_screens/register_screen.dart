import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/register_controller.dart';
import 'package:vaadagai/app_router/app_router.dart';
import 'package:vaadagai/app_utils/app_colors.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

import '../app_utils/app_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 100,
              child: ListView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildSizedBoxHeightFun(context, height: 30),
                          buildVaadagaiLogo(
                            context,
                            AppConstants.vaadagaiLogoUrl,
                            height: 70,
                            width: 80,
                          ),
                          buildSizedBoxHeightFun(context, height: 20),
                          Center(
                            child: buildTextFun(
                              context,
                              AppConstants.register,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          buildSizedBoxHeightFun(context, height: 30),
                          buildTextFormFieldFun(
                            context: context,
                            text: AppConstants.name,
                            hintText: AppConstants.enterYourName,
                            controller: registerController.regNameController,
                            isSmallSize: false,
                          ),
                          buildSizedBoxHeightFun(context, height: 20),
                          buildTextFormFieldFun(
                            context: context,
                            text: AppConstants.mobileNumber,
                            hintText: AppConstants.enterTenDigitNumber,
                            controller:
                                registerController.regMobileNumberController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            isSmallSize: false,
                          ),
                          buildSizedBoxHeightFun(context, height: 20),
                          buildTextFormFieldFun(
                            context: context,
                            text: AppConstants.emailAddress,
                            hintText: AppConstants.enterEmailId,
                            controller:
                                registerController.regEmailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            isSmallSize: false,
                          ),
                          buildSizedBoxHeightFun(context, height: 20),
                          buildTextFormFieldFun(
                              context: context,
                              text: AppConstants.password,
                              hintText: AppConstants.enterYourPassword,
                              controller:
                                  registerController.regPasswordController,
                              isPassword: true,
                              isSmallSize: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(8)
                              ]),
                          buildSizedBoxHeightFun(context, height: 20),
                          buildTextFormFieldFun(
                              context: context,
                              text: AppConstants.confirmPassword,
                              hintText: AppConstants.confirmPassword,
                              controller: registerController
                                  .regConfirmPasswordController,
                              isPassword: true,
                              isSmallSize: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(8)
                              ]),
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
                                    groupValue:
                                        registerController.radioButton.value,
                                    onChanged: (value) {
                                      registerController.radioButton.value =
                                          value!;
                                      print("Selected: ${AppConstants.buyer}");
                                    },
                                    activeColor: AppColors.orange,
                                  ),
                                  buildSizedBoxWidthFun(context, width: 8),
                                  buildTextFun(
                                    context,
                                    AppConstants.seller,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                  ),
                                  Radio<String>(
                                    value: AppConstants.seller,
                                    groupValue:
                                        registerController.radioButton.value,
                                    onChanged: (value) {
                                      registerController.radioButton.value =
                                          value!;
                                      print("Selected: ${AppConstants.seller}");
                                    },
                                    activeColor: AppColors.orange,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 60,
              right: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildContainerButtonFun(context, AppConstants.register,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.orange, onPressed: () {
                    print('Register button clicked!');
                    registerController.register(context);
                    // Get.offNamed(AppRouter.GETSTARTED_SCREEN);
                  }),
                  buildSizedBoxHeightFun(context, height: 5),
                  buildTextFun(
                    context,
                    AppConstants.alreadyHaveAccount,
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
            ),
          ],
        ),
      ),
    );
  }
}
