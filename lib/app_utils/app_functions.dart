import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaadagai/app_controller/add_property_controller.dart';
import 'package:vaadagai/app_model/sale_model.dart';

import '../app_controller/agent_controller.dart';
import '../app_controller/auth_controller.dart';
import '../app_model/rent_model.dart';
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

Widget buildImageFun(BuildContext context, String image,
    {double? height, double? width, Color? color}) {
  return FutureBuilder(
    future: precacheImage(NetworkImage(image), context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Image.network(
          image,
          height: height,
          width: width,
          fit: BoxFit.fitWidth,
          color: color,
        );
      } else if (snapshot.hasError) {
        return Icon(
          Icons.error,
          color: Colors.red,
          size: 40,
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

buildTextFun(
  BuildContext context,
  String text, {
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
  bool buttonpress = false, // Default is false, meaning normal text
  VoidCallback? onTap,
  VoidCallback? onIconTap,
  Icon? prefixIcon,
  Color? circleColor,
  bool largetext = false,
  // Optional callback for the tap action
}) {
  return InkWell(
    onTap:
        buttonpress ? onTap : null, // Apply onTap only if buttonpress is true
    child: Row(
      mainAxisSize: MainAxisSize.min, // Fit the content
      children: [
        if (prefixIcon != null) // Only show the icon if it's provided
          InkWell(
            onTap: onIconTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 10), // Add some spacing
              child: prefixIcon,
            ),
          ),
        Flexible(
          child: Text(
            text,
            textAlign: largetext ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );

  // return InkWell(
  //   onTap:
  //       buttonpress ? onTap : null, // Apply onTap only if buttonpress is true
  //   child: Text(
  //     text,
  //     style: GoogleFonts.poppins(
  //       fontSize: fontSize,
  //       fontWeight: fontWeight,
  //       color: color,
  //     ),
  //   ),
  // );
}

Widget buildContainerButtonFun(
  BuildContext context,
  String text, {
  required int fontSize,
  required FontWeight fontWeight,
  Color? color,
  Function()? onPressed,
  required double height,
  required double width,
  Color? fontColor = Colors.white,
  bool circle = false,
  Color? circleColor = Colors.black,
  bool showIcon = false,
  bool centerText = true,
  double borderRadius = 32,
  Color? circleTextColor = AppColors.orange,
  // New parameter to control text alignment
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      decoration: circle
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: circleColor!, width: 2.3),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(32),
            ),
      child: Row(
        mainAxisAlignment: centerText
            ? MainAxisAlignment.center
            : MainAxisAlignment.start, // Conditional alignment for text
        children: [
          if (showIcon) ...[
            Icon(
              Icons.add,
              color: AppColors.orange,
              size: 24,
            ),
            buildSizedBoxWidthFun(context, width: 5),
          ],
          buildSizedBoxWidthFun(context,
              width: centerText ? 5 : 16), // Add padding for left alignment
          buildTextFun(
            context,
            text,
            fontSize: 16, // Use the parameter instead of hardcoded value
            fontWeight: fontWeight,
            color: circle ? circleTextColor! : fontColor!,
          ),
        ],
      ),
    ),
  );
}

// Widget buildTextFormFieldFun(
//     {required BuildContext context,
//     required String text,
//     required String hintText,
//     TextEditingController? controller,
//     bool isSmallSize = true,
//     double? fontSize,
//     TextInputType? keyboardType,
//     List<TextInputFormatter>? inputFormatters,
//     bool isPassword = false,
//     String? prefixImage,
//     bool isHeightSize = true}) {
//   bool obscureText = isPassword;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // Field Label
//       buildTextFun(
//         context,
//         text,
//         fontSize: 16,
//         fontWeight: FontWeight.w500,
//         color: Colors.black,
//       ),
//       buildSizedBoxHeightFun(context, height: 6),
//       StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             height: isHeightSize ? 56 : 194,
//             width: 343,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(32.0),
//               border: Border.all(color: Colors.grey),
//             ),
//             child: TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               inputFormatters: inputFormatters,
//               obscureText: isPassword ? obscureText : false,
//               maxLines: isHeightSize ? 1 : null,
//               // Single line for small size, multi-line otherwise
//               maxLength: isHeightSize ? null : 500,
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(
//                   fontSize: fontSize ?? 14,
//                   color: AppColors.grey,
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 16.0, // Adjust padding to align the text vertically
//                   horizontal: 16.0,
//                 ),
//                 prefixIcon: prefixImage != null
//                     ? Padding(
//                         padding: const EdgeInsets.all(
//                             12.0), // Adjust padding as needed
//                         child: buildImageFun(context, prefixImage,
//                             height: 20, width: 20))
//                     : null,
//                 suffixIcon: isPassword
//                     ? IconButton(
//                         icon: Icon(
//                           obscureText ? Icons.visibility_off : Icons.visibility,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             obscureText = !obscureText;
//                           });
//                         },
//                       )
//                     : null,
//               ),
//               style: const TextStyle(
//                 overflow: TextOverflow
//                     .ellipsis, // Ensures text does not overflow the field
//               ),
//             ),
//           );
//         },
//       ),
//     ],
//   );
// }

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
  String? prefixImage,
  bool isHeightSize = true,
  bool isMediumSize = true,
  bool isWidthSize = true,
  bool dropdown = false,
  bool textColors = true,
  bool prefixColor = true,
  List<String>? dropdownItems,
  ValueChanged<String?>? onChanged,
  RxString? selectedValue,
  double borderRadius = 32.0, // Add this parameter to bind the selected value
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
        color: textColors ? Colors.black : AppColors.orange,
      ),
      buildSizedBoxHeightFun(context, height: 6),
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: isHeightSize
                ? 56
                : isMediumSize
                    ? 194
                    : 40,
            width: isWidthSize ? 343 : 166,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.grey),
            ),
            child: dropdown
                ? Obx(() {
                    return DropdownButtonFormField<String>(
                      value: selectedValue?.value.isEmpty ?? true
                          ? null
                          : selectedValue?.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        prefixIcon: prefixImage != null
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: buildImageFun(context, prefixImage,
                                    height: 20, width: 20),
                              )
                            : null,
                      ),
                      dropdownColor: Colors.white,
                      menuMaxHeight: 100,
                      hint: Text(
                        hintText,
                        style: TextStyle(
                          fontSize: fontSize ?? 14,
                          color: AppColors.grey,
                        ),
                      ),
                      items: dropdownItems
                          ?.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (selectedValue != null) {
                          selectedValue.value = value ?? '';
                        }
                        if (onChanged != null) {
                          onChanged(value);
                        }
                      },
                    );
                  })
                : TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    obscureText: isPassword ? obscureText : false,
                    maxLines: isHeightSize ? 1 : null,
                    maxLength: isHeightSize ? null : 500,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: fontSize ?? 14,
                        color: AppColors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      prefixIcon: prefixImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: buildImageFun(context, prefixImage,
                                  height: 20,
                                  width: 20,
                                  color: prefixColor
                                      ? AppColors.black
                                      : AppColors.orange),
                            )
                          : null,
                      suffixIcon: isPassword
                          ? IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          );
        },
      ),
    ],
  );
}

void buildScaffoldSuccessMessage(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: 20.0,
      right: 20.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 10), // Spacing between icon and text
              Expanded(
                child: buildTextFun(context, message,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundWhite),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void buildScaffoldErrorMessage(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: 20.0,
      right: 20.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 10), // Spacing between icon and text
              Expanded(
                child: buildTextFun(context, message,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundWhite),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

//------------------Login Functions-------------------//
buildLoginButtonFun(BuildContext context, AuthController authController) {
  return Column(
    children: [
      buildContainerButtonFun(context, AppConstants.loginSmall,
          height: 50,
          width: MediaQuery.of(context).size.width,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.orange, onPressed: () {
        print('Login button clicked!');

        authController.login(context);
      }),
      buildSizedBoxHeightFun(context, height: 10),
      buildTextFun(
        context,
        AppConstants.dontHaveAccountRegister,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
        buttonpress: true,
        // This will make the text clickable
        onTap: () {
          print('Dont HaveAccountRegister Text clicked!');
          Get.toNamed(AppRouter.REGISTER_SCREEN);
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
            height: 50,
            width: MediaQuery.of(context).size.width,
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
          buttonpress: true,
          // This will make the text clickable
          onTap: () {
            print('Dont HaveAccountRegister Text clicked!');
            Get.toNamed(AppRouter.LOGIN_SCREEN);
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
// top logo image function

buildTopLogoFun(BuildContext context, String imageUrl,
    {double height = 46, double width = 52}) {
  return Align(
    alignment:
        Alignment.topLeft, // Ensures the logo is aligned to the top-left corner
    child: Padding(
      padding: const EdgeInsets.only(
          top: 8, left: 26), // Padding from the top and left
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4), // Border radius of 4
        child: Image.network(
          imageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover, // Adjust BoxFit if needed
        ),
      ),
    ),
  );
}

//----------------------------------ADD SALE-----------------------------//

buildAgentHeaderFun(BuildContext context, String addProperty) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the start
    children: [
      buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
      buildSizedBoxHeightFun(context, height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print('property add screen click');
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8), // Adds spacing between the icon and text
            buildTextFun(
              context,
              addProperty,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    ],
  );
}

buildAgentAddSaleBodyFun(
  context,
  AddPropertyController addPropertyController,
) {
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildTextFormFieldFun(
            context: context,
            text: AppConstants.propertyType,
            hintText: AppConstants.choosePropertyType,
            dropdown: true,
            dropdownItems: addPropertyController.propertyTypeItemsForSale,
            selectedValue: addPropertyController.selectedPropertyType,
            onChanged: (value) {
              print("Selected value: $value");
            },
            prefixImage: AppConstants.propertytypeIconImage,
          ),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.postalCode,
              hintText: AppConstants.enterPostalCode,
              controller: addPropertyController.addPostalCodeController,
              isSmallSize: false,
              prefixImage: AppConstants.hashtagIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.unit,
              hintText: AppConstants.enterUnit,
              controller: addPropertyController.addUnitController,
              keyboardType: TextInputType.phone,
              isSmallSize: false,
              prefixImage: AppConstants.unitIconImage,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
            context: context,
            text: AppConstants.street,
            hintText: AppConstants.enterTheStreet,
            controller: addPropertyController.addStreetController,
            isSmallSize: false,
            prefixImage: AppConstants.streetIconImage,
          ),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.totalFloors,
              hintText: AppConstants.totalFloors,
              controller: addPropertyController.addTotalFloorsController,
              isSmallSize: false,
              prefixImage: AppConstants.floorIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.floorNo,
              hintText: AppConstants.floorNo,
              controller: addPropertyController.addFloorNoController,
              isSmallSize: false,
              prefixImage: AppConstants.floorIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.builtUpAreaSqft,
              hintText: AppConstants.sqFt,
              controller: addPropertyController.addSqftController,
              isSmallSize: false,
              prefixImage: AppConstants.sqftIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.bhk,
              hintText: AppConstants.enterBhk,
              controller: addPropertyController.addBhkController,
              isSmallSize: false,
              prefixImage: AppConstants.bhkIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.bathrooms,
              hintText: AppConstants.noOfBathrooms,
              controller: addPropertyController.addBathroomsController,
              isSmallSize: false,
              prefixImage: AppConstants.bathroomIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.price,
              hintText: AppConstants.price,
              controller: addPropertyController.addPriceController,
              isSmallSize: false,
              prefixImage: AppConstants.pricetagIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.additionalDetails,
              hintText: AppConstants.typeHere,
              controller: addPropertyController.addAdditionalDetailsController,
              isSmallSize: false,
              isHeightSize: false),
        ],
      ),
    );
  }
}

//--------------------Agent_Sale_Button_Function--------------------//
buildAgentAddSaleButtonFun(BuildContext context,
    AddPropertyController addPropertyController, SaleModel? saleModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return buildContainerButtonFun(
            context,
            addPropertyController.isSaleEditId.value
                ? AppConstants.update
                : AppConstants.done,
            fontSize: 16,
            height: 50,
            width: MediaQuery.of(context).size.width,
            fontWeight: FontWeight.w500,
            color: AppColors.orange,
            onPressed: () {
              if (addPropertyController.isSaleEditId.value) {
                // Update operation
                print('Update button clicked!');
                addPropertyController.addUpdateSaleProperty(context,
                    updateSaleId: saleModel!.saleId,
                    createdAt: saleModel!.addSaleCreatedAt);
                // addPropertyController.updateSaleProperty(context);
              } else {
                // Add operation
                print('Add button clicked!');
                addPropertyController.addUpdateSaleProperty(context);
              }
            },
          );
        }),
      ],
    ),
  );
}

//-------------------  add rent property  ----------------------//

buildAgentAddRentBodyFun(
  context,
  AddPropertyController addPropertyController,
) {
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildTextFormFieldFun(
            context: context,
            text: AppConstants.propertyType,
            hintText: AppConstants.choosePropertyType,
            dropdown: true,
            dropdownItems: addPropertyController.propertyTypeItemsForRent,
            selectedValue: addPropertyController.selectedPropertyType,
            onChanged: (value) {
              print("Selected value: $value");
            },
            prefixImage: AppConstants.propertytypeIconImage,
          ),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.postalCode,
              hintText: AppConstants.enterPostalCode,
              controller: addPropertyController.addPostalCodeController,
              isSmallSize: false,
              prefixImage: AppConstants.hashtagIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.unit,
              hintText: AppConstants.enterUnit,
              controller: addPropertyController.addUnitController,
              isSmallSize: false,
              prefixImage: AppConstants.unitIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
            context: context,
            text: AppConstants.street,
            hintText: AppConstants.enterTheStreet,
            controller: addPropertyController.addStreetController,
            isSmallSize: false,
            prefixImage: AppConstants.streetIconImage,
          ),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.floorNo,
              hintText: AppConstants.floorNo,
              controller: addPropertyController.addFloorNoController,
              isSmallSize: false,
              prefixImage: AppConstants.floorIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.builtUpAreaSqft,
              hintText: AppConstants.sqFt,
              controller: addPropertyController.addSqftController,
              isSmallSize: false,
              prefixImage: AppConstants.sqftIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.bhk,
              hintText: AppConstants.enterBhk,
              controller: addPropertyController.addBhkController,
              isSmallSize: false,
              prefixImage: AppConstants.bhkIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.bathrooms,
              hintText: AppConstants.noOfBathrooms,
              controller: addPropertyController.addBathroomsController,
              isSmallSize: false,
              prefixImage: AppConstants.bathroomIconImage,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ]),
          buildSizedBoxHeightFun(context, height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFun(context, AppConstants.price,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                buildSizedBoxHeightFun(context, height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildTextFormFieldFun(
                          context: context,
                          text: AppConstants.advance,
                          hintText: '',
                          prefixImage: AppConstants.dollarIconImage,
                          controller:
                              addPropertyController.addAdvanceController,
                          isMediumSize: false,
                          isHeightSize: true,
                          isWidthSize: false,
                          textColors: false,
                          prefixColor: false,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ]),
                      buildSizedBoxWidthFun(context, width: 5),
                      buildTextFormFieldFun(
                          context: context,
                          text: AppConstants.rent,
                          hintText: '',
                          prefixImage: AppConstants.dollarIconImage,
                          isMediumSize: false,
                          controller: addPropertyController.addRentController,
                          isHeightSize: true,
                          isWidthSize: false,
                          textColors: false,
                          prefixColor: false,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildSizedBoxHeightFun(context, height: 20),
          buildTextFormFieldFun(
              context: context,
              text: AppConstants.additionalDetails,
              hintText: AppConstants.typeHere,
              controller: addPropertyController.addAdditionalDetailsController,
              isSmallSize: false,
              isHeightSize: false),
        ],
      ),
    );
  }
}

//---------------------------Agent_Rent_Button_Function-----------------//
buildAgentAddRentButtonFun(BuildContext context,
    AddPropertyController addPropertyController, RentModel? rentModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return buildContainerButtonFun(
              context,
              addPropertyController.isRentEditId.value
                  ? AppConstants.update
                  : AppConstants.done,
              fontSize: 16,
              height: 50,
              width: MediaQuery.of(context).size.width,
              fontWeight: FontWeight.w500,
              color: AppColors.orange, onPressed: () {
            print('Done button clicked!');
            // addPropertyController.addRentProperty(context);
            if (addPropertyController.isRentEditId.value) {
              // Update operation
              print('Update button clicked!');
              addPropertyController.addUpdateRentProperty(context,
                  updateRentId: rentModel!.rentId,
                  createdAt: rentModel!.addRentCreatedAt);
              // addPropertyController.updateSaleProperty(context);
            } else {
              // Add operation
              print('Add button clicked!');
              addPropertyController.addUpdateRentProperty(context);
            }
          });
        })
      ],
    ),
  );
}

Widget loadingProgress(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: AppColors.primaryBlue,
      color: AppColors.white,
    ),
  );
}

void logout(BuildContext context) {
  Get.dialog(
    Stack(
      children: [
        // Blurred Background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black
                .withOpacity(0.5), // Optional: Add a semi-transparent overlay
          ),
        ),

        // Dialog Box
        Center(
          child: AlertDialog(
            contentPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Center(
              child: Text(
                'Want to Logout?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tick Icon Container for confirming logout
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          AppColors.primaryBlue, // Border color for tick icon
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.check),
                    color: AppColors.primaryBlue,
                    onPressed: () {
                      Get.find<AgentController>().selectedIndex.value = 0;

                      Get.toNamed(
                        AppRouter.LOGIN_SCREEN,
                      );
                      buildScaffoldSuccessMessage(
                          context, "Logged Out Successfully");
                    },
                  ),
                ),

                SizedBox(width: 20), // Space between icons

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.orange, // Background color for close icon
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    barrierColor: Colors
        .transparent, // Ensure background is fully visible for blur effect
  );
}

Widget buildSaleFetchContainerFun(
  BuildContext context,
  AddPropertyController addPropertyController,
) {
  print("buildFetchContainerFun started....");

  final ScrollController fetchScrollController = ScrollController();

  return Obx(() {
    // Check loading state first
    if (addPropertyController.isLoading.value) {
      return loadingProgress(context); // Show loading indicator
    }

    // Check if the list is empty
    if (addPropertyController.saleList.isEmpty) {
      return Center(
        child: buildTextFun(context, AppConstants.noData,
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }

    // If data is available, show the list
    return Scrollbar(
      thumbVisibility: true,
      controller: fetchScrollController,
      child: ListView.builder(
        controller: fetchScrollController,
        itemCount: addPropertyController.saleList.length,
        itemBuilder: (context, index) {
          final sale = addPropertyController.saleList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                print("Sale ID : ${sale.saleId}");
                Get.toNamed(
                  AppRouter.AGENT_SALE_DETAIL_SCREEN,
                  arguments: sale,
                );
              },
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextFun(
                        context,
                        sale.addPropertyType,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      buildSizedBoxHeightFun(context, height: 8),
                      buildTextFun(
                        context,
                        'Area: ${sale.addSqft}',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      buildSizedBoxHeightFun(context, height: 8),
                      buildTextFun(
                        context,
                        '₹${sale.addPrice}',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      buildSizedBoxHeightFun(context, height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.red, size: 18.0),
                          buildSizedBoxWidthFun(context, width: 4),
                          Expanded(
                            child: buildTextFun(
                              context,
                              sale.addStreet,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      buildSizedBoxHeightFun(context, height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.red, size: 18.0),
                          buildSizedBoxWidthFun(context, width: 4),
                          buildTextFun(
                            context,
                            getTimeDifference(sale.addSaleCreatedAt),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildTextFun(
                          context,
                          'View Details >>',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  });
}

Widget buildRentFetchContainerFun(
  BuildContext context,
  AddPropertyController addPropertyController,
) {
  print("buildFetchContainerFun started....");

  final ScrollController fetchScrollController = ScrollController();

  return Obx(() {
    if (addPropertyController.isLoading.value) {
      return loadingProgress(context); // Show loading indicator
    }

    if (addPropertyController.rentList.isEmpty) {
      return Center(
        child: buildTextFun(context, AppConstants.noData,
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }

    return Scrollbar(
        thumbVisibility: true,
        controller: fetchScrollController,
        child: Obx(() {
          return ListView.builder(
            controller: fetchScrollController,
            itemCount: addPropertyController.rentList.length,
            itemBuilder: (context, index) {
              final rent = addPropertyController.rentList[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    print("Rent ID : ${rent.rentId}");
                    Get.toNamed(
                      AppRouter.AGENT_RENT_DETAIL_SCREEN,
                      arguments: rent,
                    );
                  },
                  child: Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextFun(context, rent.addPropertyType,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                        buildSizedBoxHeightFun(context, height: 8),
                        buildTextFun(context, 'Area: ${rent.addSqft}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black),
                        buildSizedBoxHeightFun(context, height: 8),
                        buildTextFun(context, '₹${rent.addRent}',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                        buildSizedBoxHeightFun(context, height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.red, size: 18.0),
                            buildSizedBoxWidthFun(context, width: 4),
                            Expanded(
                              child: buildTextFun(
                                context,
                                rent.addStreet,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        buildSizedBoxHeightFun(context, height: 10),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.red, size: 18.0),
                            buildSizedBoxWidthFun(context, width: 4),
                            buildTextFun(context,
                                getTimeDifference(rent.addRentCreatedAt),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: buildTextFun(context, 'View Details >>',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }));
  });
}

String getTimeDifference(DateTime postTime) {
  final now = DateTime.now(); // current time
  final difference = now.difference(postTime); // post time = past time

  if (difference.inMinutes < 1) {
    return 'Just now'; // For less than a minute
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
  } else if (difference.inDays < 30) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''}';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''}';
  }
}

buildProfileHeaderFun(
  BuildContext context,
  String profile,
) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the start
    children: [
      buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
      buildSizedBoxHeightFun(context, height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                print('profile screen click');
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8), // Adds spacing between the icon and text
            buildTextFun(
              context,
              profile,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildPropertySaleDetailsHeaderFun(
  BuildContext context,
  String profile,
  SaleModel? saleModel,
  AddPropertyController addPropertyController,
) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the start
    children: [
      buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
      buildSizedBoxHeightFun(context, height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print('Property Details screen click');
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8), // Adds spacing between the icon and text
            buildTextFun(
              context,
              profile,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            const Spacer(), // Pushes the buttons to the right side
            IconButton(
              onPressed: () {
                print('Edit button clicked');
                print("Property SaleId: ${saleModel?.saleId} ");
                Get.toNamed(AppRouter.AGENT_ADD_SALE_SCREEN,
                    arguments: saleModel);
              },
              icon: const Icon(Icons.edit, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: AppConstants.delete,
                  middleText: AppConstants.deleteMsg,
                  textConfirm: AppConstants.yes,
                  textCancel: AppConstants.cancel,
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Call deleteSaleData and pass the saleId
                    addPropertyController.deleteSaleData(
                        context, saleModel!.saleId);
                  },
                );
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildPropertyAddHeaderFun(
  BuildContext context,
  String profile,
) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the start
    children: [
      buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
      buildSizedBoxHeightFun(context, height: 16),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              print('Property Details screen click');
              Get.back();
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 8), // Adds spacing between the icon and text
          buildTextFun(
            context,
            profile,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ],
      ),
    ],
  );
}

buildPropertyRentDetailsHeaderFun(BuildContext context, String propertyDetails,
    RentModel? rentModel, AddPropertyController addPropertyController) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Aligns children to the start
    children: [
      buildTopLogoFun(context, AppConstants.vaadagaiLogoUrl),
      buildSizedBoxHeightFun(context, height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print('Property Details screen click');
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 8), // Adds spacing between the icon and text
            buildTextFun(
              context,
              propertyDetails,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            const Spacer(), // Pushes the buttons to the right side
            IconButton(
              onPressed: () {
                print('Edit button clicked');
                print("Rent property ID : ${rentModel?.rentId}");
                Get.toNamed(AppRouter.AGENT_ADD_RENT_SCREEN,
                    arguments: rentModel);
              },
              icon: const Icon(Icons.edit, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: AppConstants.delete,
                  middleText: AppConstants.deleteMsg,
                  textConfirm: AppConstants.yes,
                  textCancel: AppConstants.cancel,
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    // Call deleteSaleData and pass the saleId
                    addPropertyController.deleteRentData(
                        context, rentModel!.rentId);
                  },
                );
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    ],
  );
}
