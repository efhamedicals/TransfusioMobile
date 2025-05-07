import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/core/utils/helpers/bottom_sheet_helper.dart';
import 'package:transfusio/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:transfusio/src/features/profile/presentation/widgets/profile_item_widget.dart';
import 'package:transfusio/src/shared/presentation/widgets/buttons/sized_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel profileViewModel = locator<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    final height = Dimensions.getScreenHeight(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: height * 0.27,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.banner),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        baseUrl +
                        (AppServices.instance.currentUser.value!.avatar ?? ""),
                    errorWidget:
                        (context, url, error) => Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18,
                          ),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(AppAssets.defaultAvatar),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(),
                        ),
                    imageBuilder:
                        (context, imageProvider) => Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.18,
                          ),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(),
                        ),
                  ),
                ),
              ],
            ),
            Text(
              AppServices.instance.currentUser.value!.firstname!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primaryColor,
                fontSize: 30,
              ),
            ),
            Text(
              AppServices.instance.currentUser.value!.email ??
                  AppServices.instance.currentUser.value!.phone!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Dimensions.verticalSpacer(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "COMPTE",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                      Dimensions.horizontalSpacer(5),
                      GestureDetector(
                        onTap: () {
                          AppRouter.router
                              .push(AppRouter.editProfile)
                              .then((value) => setState(() {}));
                        },
                        child: const SizedButton(
                          width: 25,
                          height: 25,
                          radius: 7,
                          color: AppColors.thirdyColor,
                          child: FaIcon(
                            FontAwesomeIcons.pencil,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Dimensions.verticalSpacer(5),
                  accountInfosSection(),
                  Dimensions.verticalSpacer(20),
                  Text(
                    "PLUS",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  Dimensions.verticalSpacer(5),
                  appInfosSection(),
                  Dimensions.verticalSpacer(20),
                  Text(
                    "AVANCÉE",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
                  Dimensions.verticalSpacer(5),
                  handleAccountSection(),
                  Dimensions.verticalSpacer(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountInfosSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.placeholderBg2,
      ),
      child: Column(
        children: [
          ProfileItemWidget(
            leftText: "Numéro de téléphone",
            rightText: AppServices.instance.currentUser.value!.phone,
            isIcon: false,
            callback: () {
              AppRouter.router
                  .push(AppRouter.editProfile)
                  .then((value) => setState(() {}));
            },
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Adresse mail",
            rightText: AppServices.instance.currentUser.value!.email,
            isIcon: false,
            callback: () {
              AppRouter.router
                  .push(AppRouter.editProfile)
                  .then((value) => setState(() {}));
            },
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Mot de passe",
            rightText: "********",
            isIcon: true,
            callback: () {
              AppRouter.router
                  .push(AppRouter.editPassword)
                  .then((value) => setState(() {}));
            },
          ),
          const Divider(),
          Column(
            children: [
              ProfileItemWidget(
                leftText: "Nom",
                rightText: AppServices.instance.currentUser.value!.lastname!,
                isIcon: true,
                callback: () {
                  AppRouter.router
                      .push(AppRouter.editProfile)
                      .then((value) => setState(() {}));
                },
              ),
              const Divider(),
              ProfileItemWidget(
                leftText: "Prénoms",
                rightText: AppServices.instance.currentUser.value!.firstname!,
                isIcon: true,
                callback: () {
                  AppRouter.router
                      .push(AppRouter.editProfile)
                      .then((value) => setState(() {}));
                },
              ),
              const Divider(),
              ProfileItemWidget(
                leftText: "Adresse",
                rightText:
                    AppServices.instance.currentUser.value!.address ?? "",
                isIcon: true,
                callback: () {
                  AppRouter.router
                      .push(AppRouter.editProfile)
                      .then((value) => setState(() {}));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget appInfosSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.placeholderBg2,
      ),
      child: Column(
        children: [
          ProfileItemWidget(
            leftText: "Version de l'application",
            rightText: "1.0.0",
            isIcon: false,
            callback: () {},
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Mentions légales",
            rightText: "",
            isIcon: true,
            callback: () {
              AppRouter.router.push(AppRouter.legalApp);
            },
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Noter l'application",
            rightText: "",
            isIcon: true,
            callback: () async {},
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Signaler un bug",
            rightText: "",
            isIcon: true,
            callback: () {
              AppRouter.router.push(AppRouter.reportBug);
            },
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Partager transfusio!",
            rightText: "",
            isIcon: true,
            callback: () {
              profileViewModel.shareApp();
            },
          ),
        ],
      ),
    );
  }

  Widget handleAccountSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.placeholderBg2,
      ),
      child: Column(
        children: [
          ProfileItemWidget(
            leftText: "Déconnexion",
            rightText: "",
            isIcon: false,
            color: Colors.red,
            callback: () async {
              BottomSheetHelper.showModalSheetWithConfirmationButton(
                context,
                const FaIcon(FontAwesomeIcons.lock, color: Colors.white),
                "Déconnexion",
                "Êtes-vous vraiment sûr de vous deconnecter?",
                () async {
                  await AppStorage.instance.deleteDataLocal();
                  await AppServices.instance.checkUser();
                  AppRouter.router.go(AppRouter.loginPage);
                },
              );
            },
          ),
          const Divider(),
          ProfileItemWidget(
            leftText: "Supprimer mon compte",
            rightText: "",
            color: Colors.red,
            isIcon: false,
            callback: () {
              BottomSheetHelper.showModalSheetWithConfirmationButton(
                context,
                const FaIcon(FontAwesomeIcons.trash, color: Colors.white),
                "Suppresion",
                "Êtes-vous vraiment sûr de supprimer votre compte et toutes les données associées?",
                () async {
                  await profileViewModel.deleteAccount(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
