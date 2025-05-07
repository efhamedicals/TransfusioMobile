import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/features/onboarding/presentation/view_models/onboarding_view_model.dart';
import 'package:transfusio/src/features/onboarding/presentation/widgets/slider_item_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final onBoardingViewModel = locator<OnBoardingViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onBoardingViewModel.getSliderData();
    });
  }

  @override
  void dispose() {
    onBoardingViewModel.controller.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) {
                      onBoardingViewModel.changeCurrentIndex(value);
                    },
                    itemCount: onBoardingViewModel.slides.length,
                    itemBuilder: (context, index) {
                      return SliderItemWidget(
                        sliderItem: onBoardingViewModel.slides[index],
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onBoardingViewModel.slides.length,
                (index) => buildDot(index, context),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: 20,
              ),
              child: TextButton(
                onPressed: () {
                  context.go(AppRouter.loginPage);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.thirdyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Commencer maintenant!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: onBoardingViewModel.currentIndex.value == index ? 12 : 8,
      width: onBoardingViewModel.currentIndex.value == index ? 12 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            onBoardingViewModel.currentIndex.value == index
                ? Colors.white
                : Colors.white54,
      ),
    );
  }
}
