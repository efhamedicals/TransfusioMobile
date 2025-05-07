import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/pin_field.dart';

class OtpScreen extends StatefulWidget {
  final bool isLogin;
  const OtpScreen({required this.isLogin, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthViewModel authViewModel = locator<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.startCountdown();

      authViewModel.firstController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
      authViewModel.secondController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
      authViewModel.thirdController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
      authViewModel.fourthController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
      authViewModel.fifthController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
      authViewModel.sixthController.addListener(() {
        authViewModel.checkIfOtpFieldisFilled(context);
      });
    });
  }

  @override
  void dispose() {
    authViewModel.timer.value?.cancel();
    super.dispose();
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
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "${widget.isLogin ? "Vérifier" : "Consulter"} votre ${AppStorage.instance.getBool("isPhone") ? "numéro de téléphone" : "adresse mail"}",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 35),
              ),
              Dimensions.verticalSpacer(10),
              widget.isLogin
                  ? Text(
                    "Nous vous avons envoyé un code à 6 chiffres. Veuillez le renseigner pour vérifier votre ${AppStorage.instance.getBool("isPhone") ? "numéro de téléphone" : "adresse mail"}.",
                  )
                  : const Text(
                    "Nous vous avons envoyé un code à 6 chiffres. Veuillez le renseigner pour réinitialiser votre mot de passe.",
                  ),
              Dimensions.verticalSpacer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      AppStorage.instance.getString("authValue"),
                      style: const TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                  Dimensions.verticalSpacer(10),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.pencil,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Dimensions.verticalSpacer(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PinField(controller: authViewModel.firstController),
                  PinField(controller: authViewModel.secondController),
                  PinField(controller: authViewModel.thirdController),
                  PinField(controller: authViewModel.fourthController),
                  PinField(controller: authViewModel.fifthController),
                  PinField(controller: authViewModel.sixthController),
                ],
              ),
              Dimensions.verticalSpacer(30),
              authViewModel.canResendOtp.isTrue
                  ? GestureDetector(
                    onTap:
                        () =>
                            widget.isLogin
                                ? authViewModel.sendCode(context)
                                : authViewModel.sendCode(
                                  context,
                                  isFirst: false,
                                ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                        children: [
                          const TextSpan(
                            text: "Vous n'avez pas reçu de code?\n",
                          ),
                          TextSpan(
                            text: "Renvoyez un nouveau",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : Text(
                    "Renvoyer OTP dans ${authViewModel.remainingSeconds}s",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              const Spacer(),
              !authViewModel.isLoading.isTrue
                  ? RoundedButton(
                    isActive: authViewModel.isOtpFieldIsField.isTrue,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    text: 'Vérifier',
                    onPressed: () {
                      authViewModel.verifyOtp(context, widget.isLogin);
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
