import 'package:flutter/material.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/bottom_sheet_helper.dart';
import 'package:transfusio/src/core/utils/helpers/match_helper.dart';
import 'package:transfusio/src/features/psl_requests/data/models/verification_item_model.dart';
import 'package:transfusio/src/features/psl_requests/data/models/verification_response.dart';
import 'package:transfusio/src/features/psl_requests/domain/entities/hospital.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/features/psl_requests/presentation/widgets/payment_form.dart';
import 'package:transfusio/src/shared/data/models/psl_product_model.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';

class ProductsPartialAvailable extends StatefulWidget {
  final PslRequestModel pslRequestModel;
  final VerificationResponse verificationResponse;
  final BuildContext parentContext;

  const ProductsPartialAvailable({
    super.key,
    required this.pslRequestModel,
    required this.verificationResponse,
    required this.parentContext,
  });

  @override
  State<ProductsPartialAvailable> createState() =>
      _ProductsPartialAvailableState();
}

class _ProductsPartialAvailableState extends State<ProductsPartialAvailable> {
  PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();
  List<Hospital> hospitals = [];
  int amount = 0;
  @override
  void initState() {
    super.initState();
    for (VerificationItem verificationItem
        in widget.verificationResponse.data!) {
      amount += verificationItem.amount!;
      for (var element in verificationItem.bloodBanks!) {
        if (!hospitals.any(
          (Hospital hospi) => hospi.id == element["hospital"]["id"],
        )) {
          hospitals.add(
            Hospital(
              id: element["hospital"]["id"],
              name: element["hospital"]["name"],
              address: element["hospital"]["geolocation"]["name"],
              latitude: element["hospital"]["geolocation"]["latitude"],
              longitude: element["hospital"]["geolocation"]["longitude"],
            ),
          );
        }
      }
    }
  }

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
                "Produits disponibles partiellement!",
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
          "Les produits demandés n'ont pas tout été trouvés. Voici les produits trouvés et le total de la demande. Veuillez effectuer le paiement dans les 10 minutes pour confirmer votre demande.",
        ),
        Dimensions.verticalSpacer(20),
        hospitals.length == 1
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospitals.first.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Dimensions.verticalSpacer(3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                    ),
                    Dimensions.horizontalSpacer(5),
                    Text(hospitals.first.address),
                  ],
                ),
              ],
            )
            : Text("Hospitals disponibles: ${hospitals.length}"),
        Dimensions.verticalSpacer(20),
        const Text(
          "Détails de la prescription",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Dimensions.verticalSpacer(5),

        widget.pslRequestModel.products!.isNotEmpty
            ? Column(
              children: [
                ...widget.pslRequestModel.products!.map(
                  (PslProductModel? product) =>
                      (widget.verificationResponse.data!.any(
                            (e) => e.id == product!.id,
                          ))
                          ? Row(
                            children: [
                              Text(
                                MatchHelper.getProductName(product!.name!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Dimensions.horizontalSpacer(5),
                              CircleAvatar(
                                radius: 10,
                                child: Text(
                                  widget.verificationResponse.data!
                                      .firstWhere((e) => e.id == product.id)
                                      .count!
                                      .toString(),

                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                          : const Center(),
                ),
              ],
            )
            : const Center(),
        Dimensions.verticalSpacer(10),
        Text(
          "Montant total à payer: $amount FCFA",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Dimensions.verticalSpacer(10),
        Container(
          width: Dimensions.getScreenWidth(context),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            "${widget.pslRequestModel.reference}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Dimensions.verticalSpacer(15),
        RoundedButton(
          color: AppColors.secondaryColor,
          textColor: Colors.white,
          text: "Payer maintenant",
          onPressed: () {
            Navigator.pop(context);
            BottomSheetHelper.showWidgetBottomSheet(
              widget.parentContext,
              child: PaymentForm(
                parentContext: widget.parentContext,
                amount: amount,
                pslRequestModel: widget.pslRequestModel,
              ),
              height: Dimensions.getScreenHeight(widget.parentContext) * 0.5,
            );
          },
        ),
      ],
    );
  }
}
