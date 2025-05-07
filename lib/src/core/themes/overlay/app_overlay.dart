import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';

import '../colors/app_colors.dart';

class AppUiOverlay {
  static SystemUiOverlayStyle get light => SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
  );

  static SystemUiOverlayStyle get lightCustom =>
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: AppColors.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      );

  static SystemUiOverlayStyle get lightCustom1 =>
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor:
            (locator<ThemeViewModel>().isDarkModeOn)
                ? Colors.black
                : Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      );

  static SystemUiOverlayStyle get dark => SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: false,
  );
}
