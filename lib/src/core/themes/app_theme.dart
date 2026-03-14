import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transfusio/src/core/themes/typography/app_font_weight.dart';

import 'colors/app_colors.dart';
import 'colors/material_color.dart';
import 'typography/app_text_theme.dart';

class AppTheme {
  static ThemeData light(BuildContext context) => ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: getMaterialColor(AppColors.primaryColor),
    textTheme:
    // ignore: no_wildcard_variable_uses
    GoogleFonts.montserratTextTheme()
    // ignore: no_wildcard_variable_uses
    .merge(AppTextTheme.lightTextTheme(context)),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: .5,
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(
        fontWeight: AppFontWeight.extraBold,
        fontSize: 25,
      ),
      actionsIconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintStyle: const TextStyle(fontSize: 12),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(width: 1.5, color: Colors.grey.shade500),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      selectedLabelStyle: TextStyle(fontSize: 12),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        //side: const BorderSide(width: 1.5, color: Colors.grey)
      ),
      elevation: 6,
    ),
    tabBarTheme: const TabBarThemeData(labelColor: Colors.black),
    sliderTheme: const SliderThemeData(trackHeight: 2),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
    ),
  );

  static ThemeData dark(BuildContext context) => ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: getMaterialColor(AppColors.primaryColor),
    textTheme:
    // ignore: no_wildcard_variable_uses
    GoogleFonts.montserratTextTheme()
    // ignore: no_wildcard_variable_uses
    .merge(AppTextTheme.darkTextTheme(context)),
    appBarTheme: const AppBarTheme(elevation: .5, centerTitle: true),
    bottomAppBarTheme: const BottomAppBarTheme(),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      hintStyle: const TextStyle(fontSize: 12),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(width: 1.5, color: Colors.grey.shade700),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //backgroundColor: AppColors.darkBackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      selectedLabelStyle: TextStyle(fontSize: 12),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
    ),
    tabBarTheme: const TabBarThemeData(labelColor: Colors.white),
    sliderTheme: const SliderThemeData(trackHeight: 2),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
  );
}
