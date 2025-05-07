import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/app_bars/simple_app_bar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_password_field.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/pin_field.dart';

class UpdateEmailOrPhoneScreen extends StatefulWidget {
  final bool isEmail;
  final bool isFirst;
  const UpdateEmailOrPhoneScreen({
    required this.isEmail,
    this.isFirst = false,
    super.key,
  });

  @override
  State<UpdateEmailOrPhoneScreen> createState() =>
      _UpdateEmailOrPhoneScreenState();
}

class _UpdateEmailOrPhoneScreenState extends State<UpdateEmailOrPhoneScreen> {
  ProfileViewModel profileViewModel = locator<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileViewModel.initializeDataEditPhoneOrEmail(
        isEmail: widget.isEmail,
        isFirst: widget.isFirst,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title:
            (!widget.isFirst ? "Modifier : " : "") +
            (widget.isEmail ? "Adresse mail" : "Numéro de téléphone"),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              getContent(),
              const Spacer(),
              !profileViewModel.isLoading.isTrue
                  ? RoundedButton(
                    isActive: profileViewModel.btnActive.isTrue,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    text: 'Continuer',
                    onPressed: () {
                      profileViewModel.validateEmailOrPhone(
                        context,
                        widget.isEmail,
                        widget.isFirst,
                      );
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

  Widget getContent() {
    if (profileViewModel.step.value == 1) {
      return widget.isEmail ? updateEmailStep1() : updatePhoneStep1();
    } else if (profileViewModel.step.value == 2) {
      return widget.isEmail ? updateEmailStep2() : updatePhoneStep2();
    } else if (profileViewModel.step.value == 3) {
      return updatePhoneOrEmailStep3();
    } else if (profileViewModel.step.value == 4) {
      return widget.isEmail ? updateEmailStep4() : updatePhoneStep4();
    } else {}

    return const Center();
  }

  // Phone steps
  Widget updatePhoneStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enregistrez puis vérifier votre numéro de téléphone pour pouvoir réaliser les actions de récupération de compte:",
        ),
        Dimensions.verticalSpacer(10),
        const Text("1. Réinitialisation de votre mot de passe."),
        const Text("2. Changement de votre adresse mail."),
        Dimensions.verticalSpacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: Dimensions.getScreenWidth(context) * 0.3,
              child: Row(
                children: [
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: (e) {
                        profileViewModel.setCountryCode(e.dialCode.toString());
                        profileViewModel.setCountryName(e.name.toString());
                      },
                      builder: (e) {
                        return Container(
                          height: 48,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "${e!.flagUri}",
                                package: 'country_code_picker',
                                width: 32,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.caretDown,
                                size: 13,
                              ),
                            ],
                          ),
                        );
                      },
                      initialSelection: profileViewModel.countryCode.value,
                      countryFilter: const [
                        '+228',
                        '+229',
                        '+225',
                        '+226',
                        '+224',
                        '+223',
                        '+227',
                        '+221',
                        '+222',
                        '+257',
                        '+237',
                      ],
                      // optional. Shows only country name and flag
                      showCountryOnly: false,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                      showDropDownButton: true,
                    ),
                  ),
                ],
              ),
            ),
            Dimensions.horizontalSpacer(5),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Dimensions.horizontalSpacer(10),
                    Text(
                      profileViewModel.countryCode.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Dimensions.horizontalSpacer(10),
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: profileViewModel.phoneController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Numéro de téléphone",
                          hintStyle: TextStyle(
                            color: Color(0xff303030),
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        ),
                        onChanged: (value) {
                          profileViewModel.setPhone(value);
                          profileViewModel.checkIfPhoneIsChanged();
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget updatePhoneStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nous vous avons envoyé un code à 6 chiffres. Veuillez le renseigner pour vérifier votre numéro de téléphone.",
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "${profileViewModel.countryCode.value}${profileViewModel.phone.value}",
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
            Dimensions.verticalSpacer(10),
            GestureDetector(
              onTap: () => profileViewModel.setStep(1),
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
            PinField(controller: profileViewModel.firstController),
            PinField(controller: profileViewModel.secondController),
            PinField(controller: profileViewModel.thirdController),
            PinField(controller: profileViewModel.fourthController),
            PinField(controller: profileViewModel.fifthController),
            PinField(controller: profileViewModel.sixthController),
          ],
        ),
        Dimensions.verticalSpacer(30),
      ],
    );
  }

  Widget updatePhoneOrEmailStep3() {
    return Form(
      key: profileViewModel.keyForm.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mot de passe",
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 32),
          ),
          Dimensions.verticalSpacer(10),
          const Text("Saisissez votre mot de passe afin de pouvoir continuer."),
          Dimensions.verticalSpacer(20),
          CustomPasswordField(
            controller: profileViewModel.paswordController,
            hintText: 'Mot de passe',
            errorMessage: "Le mot de passe doit contenir au moins 8 caractères",
            passwordVisible: true,
          ),
          Dimensions.verticalSpacer(30),
        ],
      ),
    );
  }

  Widget updatePhoneStep4() {
    int countCharacters =
        AppServices.instance.currentUser.value!.email!.split("@")[0].length;
    String obscureText = "";
    for (var i = 0; i < countCharacters - 2; i++) {
      obscureText += "x";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pour terminer, nous avons envoyé un code à 6 chiffres sur votre adresse mail. Veuillez le renseigner pour continuer.",
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "${AppServices.instance.currentUser.value!.email!.substring(0, 2)}$obscureText@gmail.com",
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PinField(controller: profileViewModel.firstController),
            PinField(controller: profileViewModel.secondController),
            PinField(controller: profileViewModel.thirdController),
            PinField(controller: profileViewModel.fourthController),
            PinField(controller: profileViewModel.fifthController),
            PinField(controller: profileViewModel.sixthController),
          ],
        ),
        Dimensions.verticalSpacer(30),
      ],
    );
  }

  // Email's steps
  Widget updateEmailStep1() {
    return Form(
      key: profileViewModel.keyForm.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enregistrez puis vérifier votre adresse mail pour pouvoir réaliser les actions de récupération de compte:",
          ),
          Dimensions.verticalSpacer(10),
          const Text("1. Réinitialisation de votre mot de passe."),
          const Text("2. Changement de votre numéro de téléphone."),
          Dimensions.verticalSpacer(10),
          CustomTextField(
            hintText: "Ex: mardiya@gmail.com",
            controller: profileViewModel.emailController,
            value: profileViewModel.emailController.text,
            maxLength: 35,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget updateEmailStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nous vous avons envoyé un code à 6 chiffres. Veuillez le renseigner pour vérifier votre adresse mail.",
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                profileViewModel.emailController.text,
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
            Dimensions.verticalSpacer(10),
            GestureDetector(
              onTap: () => profileViewModel.setStep(1),
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
            PinField(controller: profileViewModel.firstController),
            PinField(controller: profileViewModel.secondController),
            PinField(controller: profileViewModel.thirdController),
            PinField(controller: profileViewModel.fourthController),
            PinField(controller: profileViewModel.fifthController),
            PinField(controller: profileViewModel.sixthController),
          ],
        ),
        Dimensions.verticalSpacer(30),
      ],
    );
  }

  Widget updateEmailStep4() {
    int countCharacters = AppServices.instance.currentUser.value!.phone!.length;
    String obscureText = "";
    for (var i = 0; i < countCharacters - 2; i++) {
      obscureText += "X";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pour terminer, nous avons envoyé un code à 6 chiffres sur votre numéro de téléphone. Veuillez le renseigner pour continuer.",
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "$obscureText${AppServices.instance.currentUser.value!.phone!.substring(countCharacters - 2)}",
                style: const TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
        Dimensions.verticalSpacer(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PinField(controller: profileViewModel.firstController),
            PinField(controller: profileViewModel.secondController),
            PinField(controller: profileViewModel.thirdController),
            PinField(controller: profileViewModel.fourthController),
            PinField(controller: profileViewModel.fifthController),
            PinField(controller: profileViewModel.sixthController),
          ],
        ),
        Dimensions.verticalSpacer(30),
      ],
    );
  }
}
