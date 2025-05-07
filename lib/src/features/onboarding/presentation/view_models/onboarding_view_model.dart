import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/features/onboarding/data/datasources/local/slider_data.dart';
import 'package:transfusio/src/features/onboarding/domain/entities/slider_item.dart';

class OnBoardingViewModel extends GetxController {
  var slides = <SliderItemEntity>[].obs;
  RxInt currentIndex = 0.obs;
  Rx<PageController> controller = PageController(initialPage: 0).obs;

  Future<void> getSliderData() async {
    slides.value = slidesData;
  }

  void changeCurrentIndex(int value) => currentIndex.value = value;
}
