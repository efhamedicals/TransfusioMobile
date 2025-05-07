import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SimpleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appBarColor,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
