import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_controller/auth_controller.dart';
import '../app_router/app_router.dart';
import 'app_colors.dart';
import 'app_constants.dart';

buildVaadagaiLogo(BuildContext context, String image,
    {required double height, required double width}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      image,
      height: height,
      width: width,
    ),
  );
}

buildSizedBoxHeightFun(BuildContext context, {required double height}) {
  return SizedBox(height: height);
}

buildSizedBoxWidthFun(BuildContext context, {required double width}) {
  return SizedBox(
    width: width,
  );
}

buildImageFun(BuildContext context, String image,
    {double? height, double? width}) {
  return Image.network(
    image,
    height: height,
    width: width,
  );
}

buildTextFun(
  BuildContext context,
  String text, {
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
  bool buttonpress = false, // Default is false, meaning normal text
  VoidCallback? onTap, // Optional callback for the tap action
}) {
  return InkWell(
    onTap:
        buttonpress ? onTap : null, // Apply onTap only if buttonpress is true
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    ),
  );
}

buildContainerButtonFun(BuildContext context, String text,
    {required int fontSize,
    required FontWeight fontWeight,
    required Color color,
    bool isSmallSize = false,
    Function()? onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: isSmallSize ? 56 : 48,
      width: isSmallSize ? 343 : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: buildTextFun(
          context,
          text,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget buildTextFormFieldFun({
  required BuildContext context,
  required String text,
  required String hintText,
  TextEditingController? controller,
  bool isSmallSize = true,
  double? fontSize,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  bool isPassword = false,
  bool prefixIcon = false,
}) {
  bool obscureText = isPassword;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Field Label
      buildTextFun(
        context,
        text,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      buildSizedBoxHeightFun(context, height: 6),
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 56,
            width: 343,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(color: Colors.grey),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              obscureText: isPassword ? obscureText : false,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: fontSize ?? 14,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0, // Adjust padding to align the text vertically
                  horizontal: 16.0,
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    ],
  );
}

void buildScaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.yellowAccent,
      behavior: SnackBarBehavior.floating));
}

//------------------Login Functions-------------------//
buildLoginButtonFun(BuildContext context, AuthController authController) {
  return Column(
    children: [
      buildContainerButtonFun(context, AppConstants.loginSmall,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.orange, onPressed: () {
        print('Login button clicked!');
        authController.register(context);
      }),
      buildSizedBoxHeightFun(context, height: 5),
      buildTextFun(
        context,
        AppConstants.dontHaveAccountRegister,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
        buttonpress: true, // This will make the text clickable
        onTap: () {
          print('Text clicked!');
          Get.offNamed(AppRouter.REGISTER_SCREEN);
        },
      )
    ],
  );
}

buildLoginBodyFun(BuildContext context, AuthController authController) {
  return Column(
    children: [
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
      Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextFun(
                context,
                AppConstants.loginAs,
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
  );
}

buildAuthHeaderFun(BuildContext context, String title) {
  return Column(
    children: [
      buildVaadagaiLogo(
        context,
        AppConstants.vaadagaiLogoUrl,
        height: 70,
        width: 80,
      ),
      buildSizedBoxHeightFun(context, height: 10),
      Center(
        child: buildTextFun(
          context,
          title,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    ],
  );
}
//-------------------Register Functions----------------------//
