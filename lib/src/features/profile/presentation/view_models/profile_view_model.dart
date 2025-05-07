import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/core/utils/helpers/bottom_sheet_helper.dart';
import 'package:transfusio/src/core/utils/helpers/snack_bar_helper.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/core/utils/validators/emails_validator.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:transfusio/src/features/profile/domain/usecases/delete_account_user_case.dart';
import 'package:transfusio/src/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:transfusio/src/features/profile/domain/usecases/update_user_use_case.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:share_plus/share_plus.dart';

class ProfileViewModel extends GetxController {
  // Usecases
  final UpdateUserUseCase updateUserUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final DeleteAccountUserCase deleteAccountUserCase;
  final SendOtpUseCase sendOtpUseCase;
  final VerifyPasswordUseCase verifyPasswordUseCase;

  // States
  RxBool isLoading = false.obs;
  RxString phone = "".obs;
  RxString countryCode = "+228".obs;
  RxString countryName = "Togo".obs;

  RxBool isPersonal = true.obs;

  Rx<File?> userAvatar = Rx(null);

  // Form's Controllers
  Rx<GlobalKey<FormState>> keyForm = GlobalKey<FormState>().obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController paswordController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();
  TextEditingController fifthController = TextEditingController();
  TextEditingController sixthController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxString userCountry = "".obs;
  RxString userCity = "".obs;

  // Update email or phone page
  RxInt step = 1.obs;
  RxBool btnActive = true.obs;

  void setPhone(String value) => phone.value = value;

  void setCountryCode(String value) => countryCode.value = value;

  void setCountryName(String value) => countryName.value = value;

  void setIsLoading(bool value) => isLoading.value = value;

  void setBtnActive(bool value) => btnActive.value = value;

  void setIsPersonal(bool value) => isPersonal.value = value;

  void setUserCountry(String value) => userCountry.value = value;

  void setUserCity(String value) => userCity.value = value;

  void setStep(int value) => step.value = value;

  ProfileViewModel({
    required this.updateUserUseCase,
    required this.sendOtpUseCase,
    required this.updatePasswordUseCase,
    required this.deleteAccountUserCase,
    required this.verifyPasswordUseCase,
  });

  void initializeData() {
    firstNameController.text =
        AppServices.instance.currentUser.value!.firstname!;
    lastNameController.text = AppServices.instance.currentUser.value!.lastname!;
    emailController.text = AppServices.instance.currentUser.value!.email ?? "";
    phoneController.text = AppServices.instance.currentUser.value!.phone ?? "";
  }

  Future<void> initializeDataEditPhoneOrEmail({
    required bool isEmail,
    required bool isFirst,
  }) async {
    if (isEmail) {
      emailController.text =
          AppServices.instance.currentUser.value!.email ?? "";
    } else {
      phoneController.text =
          AppServices.instance.currentUser.value!.phone != null
              ? AppServices.instance.currentUser.value!.phone!.substring(4)
              : "";
      setPhone(
        AppServices.instance.currentUser.value!.phone != null
            ? AppServices.instance.currentUser.value!.phone!.substring(4)
            : "",
      );
    }

    if (!isFirst) {
      setBtnActive(false);
      if (isEmail) {
        emailController.addListener(() {
          if (emailController.text.isNotEmpty &&
              emailValidator(emailController.text) == null &&
              emailController.text.trim() !=
                  AppServices.instance.currentUser.value!.email) {
            setBtnActive(true);
          } else {
            setBtnActive(false);
          }
        });
      }
    }
  }

  void checkIfPhoneIsChanged() {
    if (phone.value != AppServices.instance.currentUser.value!.phone) {
      setBtnActive(true);
    } else {
      setBtnActive(false);
    }
  }

  Future<void> updateUser(context) async {
    if (keyForm.value.currentState!.validate()) {
      if (isPersonal.isFalse &&
          (userCountry.value.isEmpty || userCity.value.isEmpty)) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Veuillez renseigner votre ville et votre pays.",
        );
        return;
      }

      Map<String, dynamic> data = {
        'firstname': firstNameController.text.trim(),
        'lastname': lastNameController.text.trim(),
      };

      if (userAvatar.value != null) {
        data['avatar'] = await dio.MultipartFile.fromFile(
          userAvatar.value!.path,
          filename: userAvatar.value!.path.split('/').last,
        );
      }

      final dio.FormData registerData = dio.FormData.fromMap(data);

      setIsLoading(true);

      final DataState<LoginResponse> result = await updateUserUseCase.call(
        UpdateParams(formData: registerData),
      );

      if (result is DataSuccess<LoginResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          setIsLoading(false);
          AppStorage.instance.setInstance(
            key: userData,
            value: result.data!.user,
          );
          await AppServices.instance.checkUser();
          SnackBarHelper.showCustomSnackBar(
            context,
            "Mise à jour effectuée.",
            backgroundColor: AppColors.primaryColor,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
          setIsLoading(false);
        }
      } else if (result is DataFailed<LoginResponse>) {
        setIsLoading(false);
        SnackBarHelper.showCustomSnackBar(context, result.error!.message);
      }
    }
  }

  Future<void> updatePassword(context) async {
    if (keyForm.value.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Les mots de passe ne correspondent pas.",
        );
        return;
      }

      setIsLoading(true);

      final DataState<BasicResponse> result = await updatePasswordUseCase.call(
        UpdatePasswordParams(
          oldPassword: paswordController.text.trim(),
          newPassword: newPasswordController.text.trim(),
        ),
      );

      if (result is DataSuccess<BasicResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          setIsLoading(false);

          SnackBarHelper.showCustomSnackBar(
            context,
            "Mot de passe mis à jour.",
            backgroundColor: AppColors.primaryColor,
          );
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } else {
          SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
          setIsLoading(false);
        }
      } else if (result is DataFailed<LoginResponse>) {
        setIsLoading(false);
        SnackBarHelper.showCustomSnackBar(context, result.error!.message);
      }
    }
  }

  void actionUpdateEmail(BuildContext context) {
    if (AppServices.instance.currentUser.value!.emailVerify == false) {
      AppRouter.router.push(AppRouter.updatePhoneOrEmail, extra: [true, true]);
    } else if (AppServices.instance.currentUser.value!.phone == null ||
        AppServices.instance.currentUser.value!.phoneVerify! == 0) {
      BottomSheetHelper.showStandardBottomSheet(
        context,
        title: "Téléphone manquant ou non vérifié",
        message:
            "Pour modifier votre adresse mail vous devez rajouter et vérifier un numéro téléphone.",
        extra: const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 35,
          child: FaIcon(FontAwesomeIcons.info, color: Colors.white, size: 40),
        ),
      );
    } else {
      AppRouter.router.push(AppRouter.updatePhoneOrEmail, extra: [true, false]);
    }
  }

  void actionUpdatePhoneNumber(BuildContext context) {
    if (AppServices.instance.currentUser.value!.phoneVerify == false) {
      AppRouter.router.push(AppRouter.updatePhoneOrEmail, extra: [false, true]);
    } else if (AppServices.instance.currentUser.value!.email == null ||
        AppServices.instance.currentUser.value!.emailVerify! == 0) {
      BottomSheetHelper.showStandardBottomSheet(
        context,
        title: "Email manquant ou non vérifié",
        message:
            "Pour modifier votre numéro de téléphone vous devez rajouter et vérifier une adresse mail.",
        extra: const CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 35,
          child: FaIcon(FontAwesomeIcons.info, color: Colors.white, size: 40),
        ),
      );
    } else {
      AppRouter.router.push(
        AppRouter.updatePhoneOrEmail,
        extra: [false, false],
      );
    }
  }

  Future<void> validateEmailOrPhone(context, bool isEmail, bool isFirst) async {
    bool areAllControllersFilled() {
      return firstController.text.isNotEmpty &&
          secondController.text.isNotEmpty &&
          thirdController.text.isNotEmpty &&
          fourthController.text.isNotEmpty &&
          fifthController.text.isNotEmpty &&
          sixthController.text.isNotEmpty;
    }

    String getCodeFromControllers() {
      return firstController.text +
          secondController.text +
          thirdController.text +
          fourthController.text +
          fifthController.text +
          sixthController.text;
    }

    void clearControllers() {
      firstController.clear();
      secondController.clear();
      thirdController.clear();
      fourthController.clear();
      fifthController.clear();
      sixthController.clear();
    }

    Future<void> handleStep1() async {
      if (isEmail) {
        if (emailController.text.isEmpty) {
          SnackBarHelper.showCustomSnackBar(
            context,
            "Veuillez renseigner une adresse mail.",
          );
          return;
        }
        bool result = await sendOtpPhoneOrEmail(
          email: emailController.text,
          isNew: true,
          userId: AppServices.instance.currentUser.value!.id!,
          context: context,
        );
        if (result) setStep(2);
      } else {
        if (phone.value.isEmpty) {
          SnackBarHelper.showCustomSnackBar(
            context,
            "Veuillez renseigner un numéro de téléphone.",
          );
          return;
        }
        String phoneNumber = "${countryCode.value}${phone.value}";
        bool result = await sendOtpPhoneOrEmail(
          phoneNumber: phoneNumber,
          isNew: true,
          userId: AppServices.instance.currentUser.value!.id!,
          context: context,
        );
        if (result) setStep(2);
      }
    }

    Future<void> handleStep2() async {
      if (!areAllControllersFilled()) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Veuillez renseigner le code.",
        );
        return;
      }
      String codeTapped = getCodeFromControllers();
      if (AppStorage.instance.getString("otp") != codeTapped) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Désolé, le code est incorrect!",
        );
        return;
      }
      setStep(3);
    }

    Future<void> handleStep3() async {
      if (!keyForm.value.currentState!.validate()) return;
      setIsLoading(true);
      final DataState<LoginResponse> result = await verifyPasswordUseCase.call(
        UserVerifyPasswordParams(
          id: AppServices.instance.currentUser.value!.id!,
          password: paswordController.text,
        ),
      );
      if (result is DataSuccess<LoginResponse>) {
        if (result.data!.status!) {
          bool result = false;
          if (isEmail) {
            result = await sendOtpPhoneOrEmail(
              phoneNumber: AppServices.instance.currentUser.value!.phone!,
              isNew: false,
              context: context,
            );
          } else {
            result = await sendOtpPhoneOrEmail(
              email: AppServices.instance.currentUser.value!.email!,
              isNew: false,
              context: context,
            );
          }

          if (result) {
            clearControllers();
            setStep(4);
          }
        } else {
          SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        }
      } else if (result is DataFailed<LoginResponse>) {
        SnackBarHelper.showCustomSnackBar(context, result.error!.message);
      }
      setIsLoading(false);
    }

    Future<void> handleStep4() async {
      if (!areAllControllersFilled()) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Veuillez renseigner le code.",
        );
        return;
      }
      String codeTapped = getCodeFromControllers();
      if (AppStorage.instance.getString("otp") != codeTapped) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Désolé, le code est incorrect!",
        );
        return;
      }
      if (isEmail) {
        updatePhoneOrEmail({
          'email': emailController.text,
          "email_verify": true,
        }, context);
      } else {
        String phoneNumber = "${countryCode.value}${phone.value}";
        updatePhoneOrEmail({
          'phone': phoneNumber,
          "phone_verify": true,
        }, context);
      }
    }

    switch (step.value) {
      case 1:
        await handleStep1();
        break;
      case 2:
        await handleStep2();
        break;
      case 3:
        await handleStep3();
        break;
      case 4:
        await handleStep4();
        break;
      default:
        break;
    }
  }

  Future<bool> sendOtpPhoneOrEmail({
    String? phoneNumber,
    String? email,
    required bool isNew,
    int? userId,
    required context,
  }) async {
    setIsLoading(true);

    final DataState<LoginResponse> result = await sendOtpUseCase.call(
      UserLoginParams(
        phone: phoneNumber,
        email: email,
        isNew: isNew,
        userId: userId,
      ),
    );

    if (result is DataSuccess<LoginResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        AppStorage.instance.setString(key: "otp", value: result.data!.otp!);
        SnackBarHelper.showCustomSnackBar(
          context,
          result.data!.message!,
          backgroundColor: AppColors.primaryColor,
        );

        setIsLoading(false);
        return true;
        //startCountdown(); // Start countdown
      } else {
        setIsLoading(false);
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        return false;
      }
    } else if (result is DataFailed<LoginResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
      return false;
    }

    return false;
  }

  Future<void> updatePhoneOrEmail(Map<String, dynamic> data, context) async {
    final dio.FormData registerData = dio.FormData.fromMap({
      "user_data": jsonEncode(data), // User data
    });

    setIsLoading(true);

    final DataState<LoginResponse> result = await updateUserUseCase.call(
      UpdateParams(formData: registerData),
    );

    if (result is DataSuccess<LoginResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        setIsLoading(false);
        AppStorage.instance.setInstance(
          key: userData,
          value: result.data!.user,
        );
        await AppServices.instance.checkUser();
        SnackBarHelper.showCustomSnackBar(
          context,
          "Mise à jour effectuée.",
          backgroundColor: AppColors.primaryColor,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
        setIsLoading(false);
      }
    } else if (result is DataFailed<LoginResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  Future<void> deleteAccount(context) async {
    BottomSheetHelper.showPersistentLoadingBottomSheet(
      context,
      title: "Suppression de compte",
      message: "Veuillez patientez, votre compte est en cours de suppression.",
      height: 180,
    );
    final DataState<BasicResponse> result = await deleteAccountUserCase.call(
      NoParams(),
    );

    if (result is DataSuccess<BasicResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        await AppStorage.instance.deleteDataLocal();
        await AppServices.instance.checkUser();

        AppRouter.router.go(AppRouter.loginPage);
      } else {
        Navigator.pop(context);
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
      }
    } else if (result is DataFailed<BasicResponse>) {
      Navigator.pop(context);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  void shareApp() {
    Share.share(
      "Télécharger notre application via Playstore https://play.google.com/store/apps/details?id= ou AppStore https://apps.apple.com/us/app/.",
      subject: "Partager transfusio",
    );
  }
}
