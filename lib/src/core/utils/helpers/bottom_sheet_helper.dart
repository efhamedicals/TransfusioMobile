import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:lottie/lottie.dart';

class BottomSheetHelper {
  static void showTextBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    required String lottie,
    double height = 250,
  }) {
    ThemeViewModel themeViewModel = locator<ThemeViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder:
              (ctx, setState) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: height,
                  width: Dimensions.getScreenWidth(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        themeViewModel.isDarkModeOn
                            ? Colors.grey.shade900
                            : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeViewModel.isDarkModeOn
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.xmark,
                                color:
                                    themeViewModel.isDarkModeOn
                                        ? Colors.white
                                        : Colors.black,
                                size: 18,
                              ),
                              onTap: () => Navigator.pop(ctx),
                            ),
                          ],
                        ),
                        Dimensions.verticalSpacer(20),
                        Lottie.asset(lottie, height: 100),
                        Dimensions.verticalSpacer(20),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        );
      },
    );
  }

  static showModalSheetWithConfirmationButton(
    BuildContext context,
    Widget widget,
    String title,
    String content,
    Function() onPressed,
  ) {
    final themeView = locator<ThemeViewModel>();
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 0,
      isDismissible: true,
      context: context,
      builder: (context2) {
        return StatefulBuilder(
          builder:
              (context2, setState) => Container(
                color:
                    themeView.isDarkModeOn
                        ? Colors.grey.withOpacity(0.4)
                        : Colors.white,
                height: Dimensions.getScreenHeight(context) * 0.57,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    const SizedBox(height: 15),
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 30,
                      child: widget,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:
                            themeView.isDarkModeOn
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            themeView.isDarkModeOn
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context2);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: AppColors.colorRed),
                            foregroundColor: AppColors.colorRed,
                          ),
                          child: const Text("NON"),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context2);
                            onPressed.call();
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                            foregroundColor: AppColors.primaryColor,
                          ),
                          child: const Text("OUI"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }

  static void showPersistentLoadingBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    double height = 200,
  }) {
    ThemeViewModel themeViewModel = locator<ThemeViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      isDismissible: false,
      enableDrag: false,
      builder: (ctx) {
        return PopScope(
          canPop: false,
          child: StatefulBuilder(
            builder:
                (ctx, setState) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: height,
                    width: Dimensions.getScreenWidth(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          themeViewModel.isDarkModeOn
                              ? Colors.grey.shade900
                              : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      themeViewModel.isDarkModeOn
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Dimensions.verticalSpacer(20),
                          const SpinKitDancingSquare(
                            color: AppColors.primaryColor,
                            size: 50,
                          ),
                          Dimensions.verticalSpacer(20),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        );
      },
    );
  }

  static void showStandardBottomSheet(
    BuildContext context, {
    Widget extra = const Center(),
    required String title,
    required String message,
  }) {
    ThemeViewModel themeViewModel = locator<ThemeViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder:
              (ctx, setState) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 300,
                  width: Dimensions.getScreenWidth(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        themeViewModel.isDarkModeOn
                            ? Colors.grey.shade900
                            : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alerte",
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeViewModel.isDarkModeOn
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.xmark,
                                color:
                                    themeViewModel.isDarkModeOn
                                        ? Colors.white
                                        : Colors.black,
                                size: 18,
                              ),
                              onTap: () {
                                Navigator.pop(ctx);
                              },
                            ),
                          ],
                        ),
                        Dimensions.verticalSpacer(20),
                        extra,
                        Dimensions.verticalSpacer(20),
                        Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color:
                                themeViewModel.isDarkModeOn
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        Dimensions.verticalSpacer(20),
                        Text(
                          textAlign: TextAlign.center,
                          message,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Dimensions.verticalSpacer(10),
                        RoundedButton(
                          isActive: true,
                          color: Colors.black,
                          textColor: Colors.white,
                          text: 'Fermer',
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        );
      },
    );
  }

  static void showWidgetBottomSheet(
    BuildContext context, {
    required Widget child,
    double? height = 300,
  }) {
    ThemeViewModel themeViewModel = locator<ThemeViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder:
              (ctx, setState) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Line at the top
                    Container(
                      width: Dimensions.getScreenWidth(context) * 0.3,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      // Don't set a fixed height - let it adapt to content
                      constraints: BoxConstraints(
                        maxHeight:
                            height != null
                                ? min(
                                  height,
                                  MediaQuery.of(ctx).size.height * 0.85,
                                )
                                : MediaQuery.of(ctx).size.height * 0.85,
                      ),
                      width: Dimensions.getScreenWidth(context),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            themeViewModel.isDarkModeOn
                                ? Colors.grey.shade900
                                : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(child: child),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }
}
