import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_password_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  AuthViewModel authViewModel = locator<AuthViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.paswordController.addListener(() {
        if (authViewModel.paswordController.text.isEmpty) {
          authViewModel.setIsPasswordEmpty(true);
        } else {
          authViewModel.setIsPasswordEmpty(false);
        }
      });
      authViewModel.confirmPasswordController.addListener(() {
        if (authViewModel.confirmPasswordController.text.isEmpty) {
          authViewModel.setIsConfirmPasswordEmpty(true);
        } else {
          authViewModel.setIsConfirmPasswordEmpty(false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 15,
              child: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => Form(
          key: authViewModel.keyForm.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text(
                  "Créer un mot de passe",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontSize: 35),
                ),
                Dimensions.verticalSpacer(20),
                const Text(
                  "Créer un nouveau mot de passe pour vous connecter!",
                ),
                Dimensions.verticalSpacer(20),
                CustomPasswordField(
                  controller: authViewModel.paswordController,
                  hintText: 'Mot de passe',
                  errorMessage:
                      "Le mot de passe doit contenir au moins 8 caractères",
                  passwordVisible: true,
                ),
                Dimensions.verticalSpacer(10),
                CustomPasswordField(
                  controller: authViewModel.confirmPasswordController,
                  hintText: 'Confirmation',
                  errorMessage:
                      "Le mot de passe doit contenir au moins 8 caractères",
                  passwordVisible: true,
                ),
                const Spacer(),
                !authViewModel.isLoading.isTrue
                    ? RoundedButton(
                      isActive:
                          !authViewModel.isPasswordEmpty.isTrue &&
                          !authViewModel.isConfirmPasswordEmpty.isTrue,
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      text: 'Continuer',
                      onPressed: () {
                        authViewModel.createNewPassword(context);
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
      ),
    );
  }
}
