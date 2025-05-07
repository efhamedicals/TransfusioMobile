import 'package:flutter/material.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';

class LoginMethodWidget extends StatelessWidget {
  final bool isActive;
  final String title;
  final IconData iconData;
  final VoidCallback? onTap;

  const LoginMethodWidget({
    required this.title,
    required this.iconData,
    this.isActive = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: Colors.black),
            Dimensions.horizontalSpacer(10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
