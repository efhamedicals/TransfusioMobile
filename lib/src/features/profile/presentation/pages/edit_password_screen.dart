import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_password_field.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  ProfileViewModel profileViewModel = locator<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileViewModel.initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Mot de passe"),
      body: Obx(
        () => Form(
          key: profileViewModel.keyForm.value,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Dimensions.verticalSpacer(20),
              const Text("Entrez et confirmez votre nouveau mot de passe."),
              Dimensions.verticalSpacer(10),
              Text(
                "Mot de passe actuel *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomPasswordField(
                controller: profileViewModel.paswordController,
                hintText: 'Mot de passe',
                errorMessage:
                    "Le mot de passe doit contenir au moins 8 caractères",
                passwordVisible: true,
              ),
              Dimensions.verticalSpacer(10),
              Text(
                "Nouveau mot de passe *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomPasswordField(
                controller: profileViewModel.newPasswordController,
                hintText: 'Mot de passe',
                errorMessage:
                    "Le mot de passe doit contenir au moins 8 caractères",
                passwordVisible: true,
              ),
              Dimensions.verticalSpacer(10),
              Text(
                "Confirmation *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomPasswordField(
                controller: profileViewModel.confirmPasswordController,
                hintText: 'Mot de passe',
                errorMessage:
                    "Le mot de passe doit contenir au moins 8 caractères",
                passwordVisible: true,
              ),
              Dimensions.verticalSpacer(10),
              const Text(
                "Le mot de passe doit contenir:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Dimensions.verticalSpacer(5),
              Text(
                "- au moins un chiffre [0-9]",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              Dimensions.verticalSpacer(5),
              Text(
                "- au moins une lettre minuscule [a-z]",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              Dimensions.verticalSpacer(5),
              Text(
                "- au moins une lettre majuscule [A-Z]",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              Dimensions.verticalSpacer(5),
              Text(
                "- au moins un caractère special comme ! @ # & ( )",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              Dimensions.verticalSpacer(5),
              Text(
                "- au moins 8 caractères et au plus 20 caractères",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
              Dimensions.verticalSpacer(20),
              !profileViewModel.isLoading.isTrue
                  ? RoundedButton(
                    isActive: true,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    text: 'Mettre à jour',
                    onPressed: () {
                      profileViewModel.updatePassword(context);
                    },
                  )
                  : const Center(
                    child: SpinKitThreeBounce(
                      color: AppColors.secondaryColor,
                      size: 30,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
