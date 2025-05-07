import 'package:flutter/material.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';

class SizedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double radius;
  final VoidCallback? onPressed;
  final Color? color;

  const SizedButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.radius = 10,
    this.onPressed,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}
