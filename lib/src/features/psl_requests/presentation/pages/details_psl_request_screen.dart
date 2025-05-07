import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/state_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/bottom_sheet_helper.dart';
import 'package:transfusio/src/core/utils/helpers/match_helper.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/features/psl_requests/presentation/widgets/payment_form.dart';
import 'package:transfusio/src/shared/data/models/psl_product_model.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';

class DetailsPslRequestScreen extends StatefulWidget {
  final PslRequestModel pslRequestModel;
  const DetailsPslRequestScreen({super.key, required this.pslRequestModel});

  @override
  State<DetailsPslRequestScreen> createState() =>
      _DetailsPslRequestScreenState();
}

class _DetailsPslRequestScreenState extends State<DetailsPslRequestScreen> {
  PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Details"),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.getScreenWidth(context),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.pslRequestModel.reference}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MatchHelper.getColor(widget.pslRequestModel),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        MatchHelper.getText(widget.pslRequestModel),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Dimensions.verticalSpacer(15),
              Text(
                "Données de la prescription",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(10),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _buildRow(
                        label: "Nom complet",
                        value:
                            widget.pslRequestModel.prescriptionFullname ?? "",
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Date de naissance",
                        value: widget.pslRequestModel.prescriptionBloodRh ?? "",
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Âge",
                        value:
                            "${widget.pslRequestModel.prescriptionAge ?? ""} ans",
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Genre",
                        value: widget.pslRequestModel.prescriptionGender ?? "",
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Group sanguin + Rhésus",
                        value:
                            '${widget.pslRequestModel.prescriptionBloodType ?? ""} ${widget.pslRequestModel.prescriptionBloodRh ?? ""} ',
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Substitution possible",
                        value:
                            (widget.pslRequestModel.prescriptionSubstitution ??
                                        0) ==
                                    1
                                ? "Oui"
                                : "Non",
                      ),
                      Dimensions.verticalSpacer(5),
                      _buildRow(
                        label: "Diagnostic",
                        value:
                            widget.pslRequestModel.prescriptionDiagnostic ?? "",
                      ),
                    ],
                  ),
                ),
              ),
              Dimensions.verticalSpacer(15),
              Text(
                "Produits demandés",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(10),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...widget.pslRequestModel.products!.map(
                        (PslProductModel? product) => Row(
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
                                product.count!.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Dimensions.verticalSpacer(15),
              Visibility(
                visible: widget.pslRequestModel.status == "paid",
                child: Center(
                  child: QrImageView(
                    data: widget.pslRequestModel.reference!,
                    version: QrVersions.auto,
                    size: 200,
                    gapless: false,
                  ),
                ),
              ),
              const Spacer(),
              pslRequestViewModel.isLoading.isTrue
                  ? const SpinKitCubeGrid(color: AppColors.primaryColor)
                  : Visibility(
                    visible: widget.pslRequestModel.status != "paid",
                    child: RoundedButton(
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      text: MatchHelper.getButtonText(widget.pslRequestModel),
                      onPressed: () {
                        if (widget.pslRequestModel.status == "not_found") {
                          pslRequestViewModel.recheckPslRequest(
                            context,
                            widget.pslRequestModel.id!,
                          );
                        } else {
                          BottomSheetHelper.showWidgetBottomSheet(
                            context,
                            child: PaymentForm(
                              parentContext: context,
                              amount:
                                  widget.pslRequestModel.payment != null
                                      ? int.parse(
                                        widget.pslRequestModel.payment["amount"]
                                            .toString(),
                                      )
                                      : 0,
                              pslRequestModel: widget.pslRequestModel,
                            ),
                            height: Dimensions.getScreenHeight(context) * 0.5,
                          );
                        }
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required String value,
    Color color = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label: '),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
