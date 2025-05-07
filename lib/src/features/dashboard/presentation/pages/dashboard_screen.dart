import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elegant_nav_bar/elegant_nav_bar.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart' as appc;
import 'package:transfusio/src/features/dashboard/presentation/view_models/dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardViewModel dashboardViewModel = locator<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: dashboardViewModel.getCurrentWidget(),
        bottomNavigationBar: ElegantBottomNavigationBar(
          backgroundColor: appc.AppColors.primaryColor,
          indicatorColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Colors.white),
          currentIndex: dashboardViewModel.getCurrentIndex(),
          onTap: (index) {
            dashboardViewModel.setCurrentIndex(index);
          },
          items: [
            NavigationItem(label: 'Accueil', icon: AppAssets.homeIcon),
            NavigationItem(label: 'Historique', icon: AppAssets.historyIcon),
            NavigationItem(
              label: 'Mon profile',
              iconWidget: const CircleAvatar(
                backgroundImage: AssetImage(AppAssets.defaultAvatar),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
