import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaadagai/app_utils/app_colors.dart';
import 'package:vaadagai/app_utils/app_constants.dart';

import 'app_router/app_router.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryBlue,
          onPrimary: AppColors.backgroundWhite,
          secondary: AppColors.orange,
          onSecondary: AppColors.backgroundWhite,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(), // Corrected line
        useMaterial3: true,
      ),
      title: AppConstants.vaadagai,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.REGISTER_SCREEN,
      getPages: AppRouter.routes,
    );
  }
}
