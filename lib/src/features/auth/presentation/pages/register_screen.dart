import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:transfusio/src/shared/presentation/widgets/avatars/update_avatar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_password_field.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthViewModel authViewModel = locator<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.getCountryInfos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: Obx(
        () => Form(
          key: authViewModel.keyForm.value,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              Text(
                "Inscription",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 25),
              ),
              Dimensions.verticalSpacer(10),
              const Text(
                "Pour finaliser la création de votre compte, nous avons besoin de quelques informations.",
              ),
              Dimensions.verticalSpacer(20),
              UpdateAvatar(
                onImageSelected: (image) {
                  authViewModel.userAvatar.value = image;
                },
              ),
              Dimensions.verticalSpacer(15),
              Text(
                "Nom *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomTextField(
                controller: authViewModel.lastNameController,
                hintText: 'Ex: BADA',
                autofocus: true,
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
                controller: authViewModel.firstNameController,
                hintText: 'Ex: Charles',
                maxLength: 30,
                errorMessage: "Le prénom est obligatoire",
              ),
              Dimensions.verticalSpacer(10),
              getPhoneOrEmailField(),
              Dimensions.verticalSpacer(10),
              Text(
                "Mot de passe *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomPasswordField(
                controller: authViewModel.paswordController,
                hintText: 'Mot de passe',
                errorMessage:
                    "Le mot de passe doit contenir au moins 8 caractères",
                passwordVisible: true,
              ),
              Dimensions.verticalSpacer(20),
              !authViewModel.isLoading.isTrue
                  ? RoundedButton(
                    isActive: true,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    text: 'Finaliser',
                    onPressed: () {
                      authViewModel.register(context);
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

  Widget getPhoneOrEmailField() {
    bool isPhone = AppStorage.instance.getBool("isPhone");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isPhone ? 'Adresse mail' : 'Numéro de téléphone',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Dimensions.verticalSpacer(5),
        isPhone
            ? CustomTextField(
              hintText: "Ex: mardiya@gmail.com",
              controller: authViewModel.emailController,
              maxLength: 35,
              keyboardType: TextInputType.emailAddress,
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: Dimensions.getScreenWidth(context) * 0.3,
                  child: Row(
                    children: [
                      Expanded(
                        child: CountryCodePicker(
                          onChanged: (e) {
                            authViewModel.setCountryCode(e.dialCode.toString());
                            authViewModel.setCountryName(e.name.toString());
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
                          initialSelection: authViewModel.countryCode.value,
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
            ),
      ],
    );
  }
}
