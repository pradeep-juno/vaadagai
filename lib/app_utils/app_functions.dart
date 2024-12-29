import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: isSmallSize ? 343 : 240,
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
