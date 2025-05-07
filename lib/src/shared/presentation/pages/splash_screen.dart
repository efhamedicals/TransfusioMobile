import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/themes/overlay/app_overlay.dart';
import 'package:transfusio/src/core/translations/dictionary.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkAndGoToNextScreen();
    });
  }

  void checkAndGoToNextScreen() {
    Future.delayed(const Duration(seconds: 5), () {
      if (AppServices.instance.currentUser.value != null) {
        goToNextScreen(AppRouter.dashboardPage);
      } else {
        if (AppStorage.instance.exist("otpVerified") &&
            AppStorage.instance.getBool("otpVerified")) {
          goToNextScreen(AppRouter.registerPage);
        } else {
          goToNextScreen(AppRouter.onBoardingPage);
        }
      }
    });
  }

  void goToNextScreen(String route) {
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppUiOverlay.lightCustom,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(AppAssets.logoSquare),
                      width: 150.0,
                      height: 150.0,
                    ),
                    Dimensions.verticalSpacer(20),
                    DefaultTextStyle(
                      style: Theme.of(
                        context,
                      ).appBarTheme.titleTextStyle!.copyWith(
                        fontSize: 40,
                        color: AppColors.primaryColor,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [WavyAnimatedText(appTitle)],
                        isRepeatingAnimation: true,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: Dimensions.getScreenHeight(context) * 0.30,
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SpinKitFoldingCube(
                    color: AppColors.primaryColor,
                    size: 40.0,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    $dict.global.loading,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
