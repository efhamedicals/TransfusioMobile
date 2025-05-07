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
import 'package:transfusio/src/shared/presentation/widgets/avatars/update_avatar.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/rounded_button.dart';
import 'package:transfusio/src/shared/presentation/widgets/textfields/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
      appBar: const SimpleAppBar(title: "Modifier mes informations"),
      body: Obx(
        () => Form(
          key: profileViewModel.keyForm.value,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Dimensions.verticalSpacer(20),
              UpdateAvatar(
                urlImage: AppServices.instance.currentUser.value!.avatar,
                onImageSelected: (image) {
                  profileViewModel.userAvatar.value = image;
                },
              ),
              Dimensions.verticalSpacer(15),
              Text(
                "Adresse mail *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomTextField(
                hintText: "Ex: mardiya@gmail.com",
                controller: profileViewModel.emailController,
                maxLength: 35,
                value: profileViewModel.emailController.text,
                keyboardType: TextInputType.emailAddress,
                enabled: false,
                suffixIcon: IconButton(
                  onPressed: () {
                    profileViewModel.actionUpdateEmail(context);
                  },
                  icon: const FaIcon(FontAwesomeIcons.pencil, size: 18),
                ),
                padding: const EdgeInsets.only(left: 15, top: 15),
              ),
              Dimensions.verticalSpacer(15),
              Text(
                "Numéro de téléphone *",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimensions.verticalSpacer(5),
              CustomTextField(
                hintText: "Ex: +228 70000000",
                controller: profileViewModel.phoneController,
                value: profileViewModel.phoneController.text,
                maxLength: 35,
                keyboardType: TextInputType.phone,
                enabled: false,
                suffixIcon: IconButton(
                  onPressed: () {
                    profileViewModel.actionUpdatePhoneNumber(context);
                  },
                  icon: const FaIcon(FontAwesomeIcons.pencil, size: 18),
                ),
                padding: const EdgeInsets.only(left: 15, top: 15),
              ),
              Dimensions.verticalSpacer(15),
              getPersonalFields(),
              Dimensions.verticalSpacer(10),
              // getPhoneOrEmailField(),
              Dimensions.verticalSpacer(20),
              !profileViewModel.isLoading.isTrue
                  ? RoundedButton(
                    isActive: true,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    text: 'Mettre à jour',
                    onPressed: () {
                      profileViewModel.updateUser(context);
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

  Widget getPersonalFields() {
    return Column(
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
          controller: profileViewModel.lastNameController,
          hintText: 'Ex: BADA',
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
          controller: profileViewModel.firstNameController,
          hintText: 'Ex: Charles',
          maxLength: 30,
          errorMessage: "Le prénom est obligatoire",
        ),
      ],
    );
  }
}
