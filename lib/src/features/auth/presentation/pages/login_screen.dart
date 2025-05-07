import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/translations/dictionary.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/validators/emails_validator.dart';
import 'package:transfusio/src/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:transfusio/src/features/auth/presentation/widgets/login_method_widget.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthViewModel authViewModel = locator<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.getCountryInfos();
      authViewModel.emailController.addListener(() {
        if (emailValidator(authViewModel.emailController.text) == null) {
          authViewModel.setEmailIsValid(true);
        } else {
          authViewModel.setEmailIsValid(false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimensions.verticalSpacer(30),
                  Text(
                    'Bienvenue sur',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 45),
                  ),
                  Text(
                    $dict.global.appName,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 45,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Dimensions.verticalSpacer(16),
                  Text(
                    'Renseigner votre numéro de téléphone ou adresse mail pour continuer.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  Dimensions.verticalSpacer(40),
                  Row(
                    children: [
                      Expanded(
                        child: LoginMethodWidget(
                          isActive: authViewModel.isPhone.isTrue,
                          title: "Téléphone",
                          iconData: FontAwesomeIcons.phone,
                          onTap: () => authViewModel.setIsPhone(true),
                        ),
                      ),
                      Dimensions.horizontalSpacer(10),
                      Expanded(
                        child: LoginMethodWidget(
                          isActive: authViewModel.isPhone.isFalse,
                          title: "Adresse mail",
                          iconData: FontAwesomeIcons.envelope,
                          onTap: () => authViewModel.setIsPhone(false),
                        ),
                      ),
                    ],
                  ),
                  Dimensions.verticalSpacer(20),
                  Text(
                    authViewModel.isPhone.isTrue
                        ? 'Numéro de téléphone'
                        : 'Adresse mail',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 16),
                  ),
                  Dimensions.verticalSpacer(10),
                  authViewModel.isPhone.isTrue
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: Dimensions.getScreenWidth(context) * 0.3,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CountryCodePicker(
                                    onChanged: (e) {
                                      authViewModel.setCountryCode(
                                        e.dialCode.toString(),
                                      );
                                      authViewModel.setCountryName(
                                        e.name.toString(),
                                      );
                                    },
                                    builder: (e) {
                                      return Container(
                                        height: 48,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                    initialSelection:
                                        authViewModel.countryCode.value,
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
                                    authViewModel.countryCode.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Dimensions.horizontalSpacer(10),
                                  Expanded(
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: authViewModel.phoneController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Numéro de téléphone",
                                        hintStyle: TextStyle(
                                          color: Color(0xff303030),
                                          fontSize: 14,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 3,
                                          left: 10,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                        authViewModel.setPhone(value);
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      : CustomTextField(
                        hintText: "Ex: mardiya@gmail.com",
                        controller: authViewModel.emailController,
                        value: authViewModel.emailController.text,
                        maxLength: 35,
                        keyboardType: TextInputType.emailAddress,
                        errorMessage: "Veuillez renseigner votre adresse mail",
                      ),
                  Dimensions.verticalSpacer(24),
                  GestureDetector(
                    onTap: () {
                      AppRouter.router.push(AppRouter.legalContent, extra: 1);
                    },
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'En continuant, vous acceptez nos ',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 15),
                        children: const [
                          TextSpan(
                            text: 'conditions',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' et '),
                          TextSpan(
                            text: 'termes d\'utilisation',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: Dimensions.getScreenHeight(context) * 0.08,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child:
                !authViewModel.isLoading.isTrue
                    ? RoundedButton(
                      isActive:
                          (authViewModel.isPhone.isTrue &&
                              authViewModel.phone.value.length >= 8) ||
                          (authViewModel.isPhone.isFalse &&
                              authViewModel.emailIsValid.isTrue),
                      color: AppColors.primaryColor,
                      textColor: Colors.white,
                      text: 'Continuer',
                      onPressed: () {
                        authViewModel.login(context);
                      },
                    )
                    : const Center(
                      child: SpinKitThreeBounce(
                        color: AppColors.secondaryColor,
                        size: 30,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
