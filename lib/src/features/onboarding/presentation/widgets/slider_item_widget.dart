import 'package:flutter/material.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/themes/typography/app_font_weight.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/onboarding/domain/entities/slider_item.dart';

class SliderItemWidget extends StatelessWidget {
  final SliderItemEntity sliderItem;

  const SliderItemWidget({super.key, required this.sliderItem});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Image(image: AssetImage(AppAssets.logoSquare)),
        ),
        Dimensions.verticalSpacer(20),
        Text(
          sliderItem.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontSize: 35,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Dimensions.verticalSpacer(25),
        Container(
          height: size.height * 0.4,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(sliderItem.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Dimensions.verticalSpacer(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            sliderItem.description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
