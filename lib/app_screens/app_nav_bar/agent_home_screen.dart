import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaadagai/app_controller/add_property_controller.dart';
import 'package:vaadagai/app_utils/app_colors.dart';

import '../../app_router/app_router.dart';
import '../../app_utils/app_constants.dart';
import '../../app_utils/app_functions.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({super.key});

  @override
  State<AgentHomeScreen> createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen>
    with SingleTickerProviderStateMixin {
  AddPropertyController addPropertyController =
      Get.put(AddPropertyController());
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      addPropertyController.fetchSale();

      print("addSaleCreatedAt23 : ${addPropertyController.addSaleCreatedAt}");

      addPropertyController.fetchRent();
    });
    _tabController =
        TabController(length: 2, vsync: this); // Two tabs: Sale and Rent
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            buildTopLogoFun(
              context,
              AppConstants.vaadagaiLogoUrl,
            ),
            buildSizedBoxHeightFun(context, height: 6),
            Positioned(
              top: 60,
              left: 5,
              right: 5,
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildImageFun(
                          context,
                          AppConstants.agentHomeScreenImage,
                          height: 202,
                          width: MediaQuery.of(context).size.width,
                        ),
                        buildSizedBoxHeightFun(context, height: 16),

                        // TabBar for Sale and Rent
                        TabBar(
                          controller: _tabController,
                          labelColor: AppColors.primaryBlue,
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelColor: Colors.grey[500],
                          tabs: const [
                            Tab(text: 'Sale'),
                            Tab(text: 'Rent'),
                          ],
                        ),
                        buildSizedBoxHeightFun(context, height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // TabBarView for Sale and Rent content
            Positioned.fill(
              top: 330,
              bottom: 150,
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildSaleFetchContainerFun(
                      context, addPropertyController), // Sale content
                  buildRentFetchContainerFun(
                      context, addPropertyController), // Rent content
                ],
              ),
            ),

            Positioned(
              bottom: 100,
              left: 76,
              right: 76,
              child: buildContainerButtonFun(
                context,
                AppConstants.addNewProperty,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                showIcon: true,
                color: AppColors.backgroundWhite,
                onPressed: () {
                  print('Add new property button clicked!');
                  Get.offNamed(AppRouter.PROPERTY_ADD_SCREEN);
                },
                height: 48,
                width: 220,
                circle: true,
                circleColor: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
