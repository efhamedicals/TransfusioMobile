import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/match_helper.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/shared/data/models/psl_product_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/cool_stepper/cool_stepper.dart';
import 'package:transfusio/src/shared/presentation/widgets/cool_stepper/models/cool_step.dart';
import 'package:transfusio/src/shared/presentation/widgets/cool_stepper/models/cool_stepper_config.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';
import 'package:transfusio/src/shared/presentation/widgets/upload_image.dart';

class AddPSLRequestScreen extends StatefulWidget {
  const AddPSLRequestScreen({super.key});

  @override
  State<AddPSLRequestScreen> createState() => _AddPSLRequestScreenState();
}

class _AddPSLRequestScreenState extends State<AddPSLRequestScreen> {
  PslRequestViewModel pslRequestViewModel = locator<PslRequestViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Faire une demande"),
      body: Obx(
        () =>
            pslRequestViewModel.isLoading.isTrue
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          strokeWidth: 10,
                          constraints: BoxConstraints(
                            minHeight: 100,
                            minWidth: 100,
                          ),
                        ),
                        Dimensions.verticalSpacer(30),
                        Text(
                          pslRequestViewModel.isSubmitted.isTrue
                              ? "Vérification de la disponibilité des produits"
                              : "Traitement des données fournies",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                )
                : pslRequestViewModel.isSubmitted.isTrue
                ? _buildRecapSection()
                : CoolStepper(
                  showErrorSnackbar: true,
                  onCompleted: () {
                    pslRequestViewModel.addPslRequest(context);
                  },
                  config: const CoolStepperConfig(
                    backText: "Précédent",
                    nextText: "Suivant",
                    finalText: "Terminer",
                    stepText: "Étape",
                    ofText: "sur",
                  ),
                  steps: [
                    CoolStep(
                      title: "Étape 1",
                      subtitle:
                          "Scannez la prescription ou l'ordonnance de produits sanguin",
                      content: _buildStep1Form(),
                      validation: () {
                        if (!pslRequestViewModel
                                .step1KeyForm
                                .value
                                .currentState!
                                .validate() ||
                            pslRequestViewModel.prescriptionFile.value ==
                                null) {
                          return "Veuillez charger la prescription ou l'ordonnance";
                        }
                        return null;
                      },
                    ),
                    CoolStep(
                      title: "Étape 2",
                      subtitle:
                          "Scannez le bulletin de groupage sanguin du patient",
                      content: _buildStep2Form(),
                      validation: () {
                        if (!pslRequestViewModel
                                .step2KeyForm
                                .value
                                .currentState!
                                .validate() ||
                            pslRequestViewModel.bloodReportFile.value == null) {
                          return "Veuillez charger le bulletin de groupage sanguin";
                        }

                        return null;
                      },
                    ),
                    CoolStep(
                      title: "Étape 3",
                      subtitle: "Confirmer les informations du patient",
                      content: _buildStep3Form(),
                      validation: () {
                        if (!pslRequestViewModel
                            .step3KeyForm
                            .value
                            .currentState!
                            .validate()) {
                          return "Veuillez renseigner tous les champs";
                        }
                        return null;
                      },
                    ),
                    CoolStep(
                      title: "Étape 4",
                      subtitle: "Informations de l'hôpital",
                      content: _buildStep4Form(),
                      validation: () {
                        if (!pslRequestViewModel
                            .step4KeyForm
                            .value
                            .currentState!
                            .validate()) {
                          return "Veuillez renseigner tous les champs";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildStep1Form() {
    return Form(
      key: pslRequestViewModel.step1KeyForm.value,
      child: Column(
        children: [
          UploadImageWidget(
            onImageSelected: (File? value) {
              pslRequestViewModel.prescriptionFile.value = value;
            },
            initialValue: pslRequestViewModel.prescriptionFile.value,
            title: "Charger la prescription ou l'ordonnance",
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Form() {
    return Form(
      key: pslRequestViewModel.step2KeyForm.value,
      child: Column(
        children: [
          UploadImageWidget(
            onImageSelected: (File? value) {
              pslRequestViewModel.bloodReportFile.value = value;
            },
            initialValue: pslRequestViewModel.bloodReportFile.value,
            title: "Charger le bulletin de groupage sanguin",
          ),
        ],
      ),
    );
  }

  Widget _buildStep3Form() {
    return Form(
      key: pslRequestViewModel.step3KeyForm.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nom *",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimensions.verticalSpacer(5),
          CustomTextField(
            controller: pslRequestViewModel.lastNameController.value,
            hintText: 'Ex: BADA',
            autofocus: true,
            value: pslRequestViewModel.lastNameController.value.text,
            maxLength: 30,
            errorMessage: "Le nom est obligatoire",
          ),
          Dimensions.verticalSpacer(10),
          Text(
            "Prénom *",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimensions.verticalSpacer(5),
          CustomTextField(
            controller: pslRequestViewModel.firstNameController.value,
            hintText: 'Ex: Charles',
            value: pslRequestViewModel.firstNameController.value.text,
            maxLength: 30,
            errorMessage: "Le prénom est obligatoire",
          ),
        ],
      ),
    );
  }

  Widget _buildStep4Form() {
    return Form(
      key: pslRequestViewModel.step4KeyForm.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nom de l'hôpital *",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimensions.verticalSpacer(5),
          CustomTextField(
            controller: pslRequestViewModel.hospitalNameController.value,
            hintText: 'Ex: Clinique des moineaux',
            value: pslRequestViewModel.hospitalNameController.value.text,
            autofocus: true,
            maxLength: 30,
            errorMessage: "Le nom de l'hôpital est obligatoire",
          ),
        ],
      ),
    );
  }

  Widget _buildRecapSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Récapitulatif des informations",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimensions.verticalSpacer(10),
          Text(
            "Informations saisies",
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
                    label: "Nom",
                    value: pslRequestViewModel.lastNameController.value.text,
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Prénoms",
                    value: pslRequestViewModel.firstNameController.value.text,
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Hôpital",
                    value:
                        pslRequestViewModel.hospitalNameController.value.text,
                  ),
                ],
              ),
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
                        pslRequestViewModel
                            .pslRequestModel
                            .value!
                            .prescriptionFullname ??
                        "",
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Date de naissance",
                    value:
                        pslRequestViewModel
                            .pslRequestModel
                            .value!
                            .prescriptionBloodRh ??
                        "",
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Âge",
                    value:
                        "${pslRequestViewModel.pslRequestModel.value!.prescriptionAge ?? ""} ans",
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Genre",
                    value:
                        pslRequestViewModel
                            .pslRequestModel
                            .value!
                            .prescriptionGender ??
                        "",
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Group sanguin + Rhésus",
                    value:
                        '${pslRequestViewModel.pslRequestModel.value!.prescriptionBloodType ?? ""} ${pslRequestViewModel.pslRequestModel.value!.prescriptionBloodRh ?? ""} ',
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Substitution possible",
                    value:
                        (pslRequestViewModel
                                        .pslRequestModel
                                        .value!
                                        .prescriptionSubstitution ??
                                    0) ==
                                1
                            ? "Oui"
                            : "Non",
                  ),
                  Dimensions.verticalSpacer(5),
                  _buildRow(
                    label: "Diagnostic",
                    value:
                        pslRequestViewModel
                            .pslRequestModel
                            .value!
                            .prescriptionDiagnostic ??
                        "",
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
                  ...pslRequestViewModel.pslRequestModel.value!.products!.map(
                    (PslProductModel? product) => Row(
                      children: [
                        Text(
                          MatchHelper.getProductName(product!.name!),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Dimensions.horizontalSpacer(5),
                        CircleAvatar(
                          radius: 10,
                          child: Text(
                            product.count!.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          RoundedButton(
            color: AppColors.primaryColor,
            textColor: Colors.white,
            text: "Confirmer et continuer",
            onPressed: () {
              pslRequestViewModel.checkPslRequest(
                context,
                pslRequestViewModel.pslRequestModel.value!.id!,
              );
            },
          ),
        ],
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
