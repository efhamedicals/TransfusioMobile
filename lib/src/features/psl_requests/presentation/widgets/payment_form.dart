import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';

class PaymentForm extends StatelessWidget {
  final PslRequestModel pslRequestModel;
  final BuildContext parentContext;
  final int amount;

  const PaymentForm({
    super.key,
    required this.pslRequestModel,
    required this.parentContext,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();

    return Obx(
      () => Form(
        key: pslRequestViewModel.paymentKeyForm.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Payer ma demande",
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
            Text(
              "Réseau mobile *",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Dimensions.verticalSpacer(5),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => pslRequestViewModel.setIsYas(true),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            pslRequestViewModel.isYas.isTrue
                                ? AppColors.thirdyColor
                                : Colors.grey,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "YAS TOGO",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Dimensions.horizontalSpacer(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => pslRequestViewModel.setIsYas(false),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            pslRequestViewModel.isYas.isFalse
                                ? AppColors.thirdyColor
                                : Colors.grey,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "FLOOZ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Dimensions.verticalSpacer(10),
            Text(
              "Numéro de téléphone *",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Dimensions.verticalSpacer(5),
            CustomTextField(
              controller: pslRequestViewModel.phoneNumberController.value,
              hintText: 'Ex: 22890000000',
              keyboardType: TextInputType.phone,
              autofocus: true,
              maxLength: 30,
              errorMessage: "Le numéro de téléphone est obligatoire",
            ),
            Dimensions.verticalSpacer(20),

            RoundedButton(
              color: AppColors.primaryColor,
              textColor: Colors.white,
              text: "Payer",
              fontSize: 12,
              onPressed: () {
                if (pslRequestViewModel.paymentKeyForm.value.currentState!
                    .validate()) {
                  Navigator.pop(context);
                  pslRequestViewModel.payPslRequest(
                    parentContext,
                    pslRequestModel.id!,
                    amount,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
