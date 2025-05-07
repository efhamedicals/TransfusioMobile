import 'package:flutter/material.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';

class AppTextTheme {
  static TextTheme lightTextTheme(BuildContext _) => const TextTheme(
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: Dimensions.fontOverLarge,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displayLarge: TextStyle(
      fontSize: Dimensions.fontOverLargeExtra,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: Dimensions.fontMediumLarge,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: Dimensions.fontOverLarge,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: Dimensions.fontMediumLarge,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme(BuildContext _) => const TextTheme(
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: Dimensions.fontOverLarge,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      fontSize: Dimensions.fontOverLargeExtra,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: Dimensions.fontMediumLarge,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: Dimensions.fontDefault,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: Dimensions.fontOverLarge,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontSize: Dimensions.fontMediumLarge,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
}
