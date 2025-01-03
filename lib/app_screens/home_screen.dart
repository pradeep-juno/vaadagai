// import 'package:flutter/material.dart';
// import 'package:vaadagai/app_utils/app_functions.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: buildTextFun(context, 'welcome to homescreen',
//           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//     ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:vaadagai/app_utils/app_colors.dart';
//
// import '../../app_utils/app_constants.dart';
// import '../../app_utils/app_functions.dart';
//
// class OnboardScreenOne extends StatefulWidget {
//   const OnboardScreenOne({super.key});
//
//   @override
//   State<OnboardScreenOne> createState() => _OnboardScreenState();
// }
//
// class _OnboardScreenState extends State<OnboardScreenOne> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         body: Stack(
//           children: [
//             ListView(
//               children: [
//                 Column(
//                   children: [
//                     buildImageFun(
//                       context,
//                       height: 494,
//                       width: 583,
//                       AppConstants.onboardScreenImaegeOne,
//                     ),
//                     buildSizedBoxHeightFun(context, height: 10),
//                     buildTextFun(context,
//                         AppConstants.onBoardingScreenOneDescriptionFirst,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.black),
//                     buildSizedBoxHeightFun(context, height: 10),
//                     buildTextFun(context,
//                         AppConstants.onBoardingScreenOneDescriptionSecond,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w300,
//                         color: AppColors.grey),
//                   ],
//                 )
//               ],
//             ),
//             Positioned(
//                 bottom: 20,
//                 left: 60,
//                 right: 60,
//                 child: buildContainerButtonFun(context, AppConstants.getStarted,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.orange, onPressed: () {
//                       print('Next button clicked!');
//                     }))
//           ],
//         ),
//       ),
//     );
//   }
// }
