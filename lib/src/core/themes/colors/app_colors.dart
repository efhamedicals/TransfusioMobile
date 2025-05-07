import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xffE9433B);
  static const Color secondaryColor = Color(0xffF06220);
  static const Color thirdyColor = Colors.black;
  static const Color yellowColor = Color.fromARGB(255, 240, 201, 27);
  static const Color goldColor = Color.fromARGB(255, 211, 139, 16);
  static const Color grisCColor = Color(0xffF4F4F4);
  static const Color whiteCColor = Color(0xffFFF8E7);
  static const Color screenBgColor = Color(0xFFF9F9F9);
  static Color primaryBgColor = primaryColor.withOpacity(.4);
  static const Color primaryTextColor = Color(0xff262626);
  static const Color contentTextColor = Color(0xff777777);
  static const Color primaryStatusBarColor = primaryColor;
  static const Color underlineTextColor = primaryColor;
  static const Color lineColor = Color(0xffECECEC);
  static const Color borderColor = Color(0xffD9D9D9);
  static const Color cofeeColor = Color.fromARGB(255, 168, 134, 76);
  static const Color roseColor = Color.fromARGB(255, 226, 62, 117);

  // app bar
  static const Color appBarColor = primaryColor;
  static const Color appBarContentColor = colorWhite;

  // text field
  static Color labelTextColor = colorBlack;
  static const Color textFieldDisableBorderColor = hintTextColor;
  static const Color textFieldEnableBorderColor = primaryColor;
  static const Color hintTextColor = Color(0xff98a1ab);

  // button
  static const Color primaryButtonColor = primaryColor;
  static const Color primaryButtonTextColor = colorWhite;
  static const Color secondaryButtonColor = colorWhite;
  static const Color secondaryButtonTextColor = colorBlack;

  // icon
  static const Color iconColor = Color(0xff555555);
  static const Color filterEnableIconColor = primaryColor;
  static const Color filterIconColor = iconColor;
  static const Color searchEnableIconColor = colorRed;
  static const Color searchIconColor = iconColor;
  static const Color bottomSheetCloseIconColor = colorBlack;

  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack = Color(0xff262626);
  static const Color colorGreen = Color(0xff28C76F);
  static const Color colorGreen100 = Color(0xffD4F4E2);
  static const Color colorOrange = Color(0xffFF9F43);
  static const Color colorOrange100 = Color(0xffFFECD9);
  static const Color colorRed = Color(0xffEA5455);
  static const Color colorRed100 = Color(0xffFCE9E9);
  static const Color colorGrey = Color(0xff555555);
  static const Color transparentColor = Colors.transparent;

  static const placeholderBg = Color.fromARGB(255, 244, 241, 241);

  static const placeholderBg2 = Color(0xFFF2F2F2);

  static const grayTransparent = Color.fromARGB(255, 227, 221, 221);

  // screen-bg & primary color
  static Color getPrimaryColor() {
    return primaryColor;
  }

  static Color getScreenBgColor() {
    return screenBgColor;
  }

  static Color getGreyText() {
    return AppColors.colorBlack.withOpacity(0.5);
  }

  static Color getPrimaryBgColor() {
    return primaryBgColor;
  }

  // appbar color
  static Color getAppBarColor() {
    return appBarColor;
  }

  static Color getAppBarContentColor() {
    return appBarContentColor;
  }

  // text color
  static Color getHeadingTextColor() {
    return primaryTextColor;
  }

  static Color getContentTextColor() {
    return contentTextColor;
  }

  // text-field color
  static Color getLabelTextColor() {
    return labelTextColor;
  }

  static Color getHintTextColor() {
    return hintTextColor;
  }

  static Color getTextFieldDisableBorder() {
    return textFieldDisableBorderColor;
  }

  static Color getTextFieldEnableBorder() {
    return textFieldEnableBorderColor;
  }

  // button color
  static Color getPrimaryButtonColor() {
    return primaryButtonColor;
  }

  static Color getPrimaryButtonTextColor() {
    return primaryButtonTextColor;
  }

  static Color getSecondaryButtonColor() {
    return secondaryButtonColor;
  }

  static Color getSecondaryButtonTextColor() {
    return secondaryButtonTextColor;
  }

  // icon color
  static Color getIconColor() {
    return iconColor;
  }

  static Color getFilterDisableIconColor() {
    return filterIconColor;
  }

  static Color getFilterEnableIconColor() {
    return filterEnableIconColor;
  }

  static Color getSearchIconColor() {
    return searchIconColor;
  }

  static Color getSearchEnableIconColor() {
    return colorRed;
  }

  // transparent color
  static Color getTransparentColor() {
    return transparentColor;
  }

  // text color
  static Color getTextColor() {
    return colorBlack;
  }

  static Color getCardBgColor() {
    return colorWhite;
  }
}
