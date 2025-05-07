import 'package:flutter/material.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';

class ProductsUnavailable extends StatelessWidget {
  final PslRequestModel pslRequestModel;

  const ProductsUnavailable({super.key, required this.pslRequestModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Aucun des produits demandés n’est disponible!",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const CircleAvatar(
              backgroundColor: AppColors.placeholderBg,
              radius: 15,
              child: Icon(Icons.close, color: Colors.black, size: 18),
            ),
          ],
        ),
        const Divider(height: 30),
        const Text(
          "Cela peut arriver en cas de forte demande ou de rupture temporaire dans les banques de sang.",
        ),
        const Text(
          "Souhaitez-vous sauvegarder cette demande pour relancer automatiquement la vérification plus tard?",
        ),
        Dimensions.verticalSpacer(20),
        Row(
          children: [
            Expanded(
              child: RoundedButton(
                color: AppColors.thirdyColor,
                textColor: Colors.white,
                text: "Sauvegarder pour plus tard",
                fontSize: 12,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            Dimensions.horizontalSpacer(10),
            SizedBox(
              width: Dimensions.getScreenWidth(context) * 0.3,
              child: RoundedButton(
                color: Colors.grey,
                textColor: Colors.white,
                text: "Annuler",
                fontSize: 12,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
