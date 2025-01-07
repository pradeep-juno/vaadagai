import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_utils/app_constants.dart';
import 'package:vaadagai/storage_services/users_storage_service.dart';

import '../app_router/app_router.dart';
import '../app_utils/app_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthState();
  }

  Future<void> _navigateBasedOnAuthState() async {
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection(AppConstants.collectionAuth)
        .doc(user?.uid)
        .get();

    if (userDoc.exists) {
      Map<String, dynamic>? userData = userDoc.data();

      if (userData != null) {
        String? localUserId = UsersStorageService.getUserId();

        print("SplashScreen -> userId : $localUserId");

        String authAs = userData['authAs'] ?? 'User';

        print("SplashScreen -> authAs : $authAs");

        String? localUserType = UsersStorageService.getUserType();

        print("SplashScreen -> localUserType : $localUserType");

        if ((authAs == localUserType) &&
            (authAs == AppConstants.agent) &&
            (localUserType == AppConstants.agent)) {
          Get.offNamed(AppRouter.AGENT_MAIN_SCREEN);
        } else if ((authAs == localUserType) &&
            (authAs == AppConstants.buyer) &&
            (localUserType == AppConstants.buyer)) {
          Get.offNamed(AppRouter.BUYER_MAIN_SCREEN);
        }
      } else {
        buildScaffoldErrorMessage(
            context, 'User data is incomplete. Please contact support.');
      }
    } else {
      Get.offNamed(AppRouter.LOGIN_SCREEN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.network(
            AppConstants.vaadagaiLogoUrl,
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
