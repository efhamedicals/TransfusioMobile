import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/features/onboarding/domain/entities/slider_item.dart';

final List<SliderItemEntity> slidesData = [
  SliderItemEntity(
    image: AppAssets.onBoarding1,
    title: "Initiez une demande de PSL",
    description:
        "Initiez une demande de PSL en scannant la fiche de prescription de produits sanguins.",
  ),
  SliderItemEntity(
    image: AppAssets.onBoarding2,
    title: "Récupérez vos PSL",
    description:
        "Réserver vos PSL et recupérez-les au sein du centre le plus proche. ",
  ),
];
