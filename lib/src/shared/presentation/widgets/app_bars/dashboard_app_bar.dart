import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:transfusio/src/features/dashboard/presentation/view_models/dashboard_view_model.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.appBarColor,

          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text("Transfusio"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40.0,
            child: Image(
              image: AssetImage(AppAssets.logoSquare),
              width: 20.0,
              height: 20.0,
            ),
          ),
        ),
        actions: [
          badges.Badge(
            showBadge:
                locator<DashboardViewModel>().getTotalNotifications() > 0,
            badgeStyle: const badges.BadgeStyle(
              badgeColor: AppColors.secondaryColor,
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 4),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.solidBell,
                color: Colors.white,
              ),
              onPressed: () {
                AppRouter.router.push(AppRouter.notifications);
              },
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
