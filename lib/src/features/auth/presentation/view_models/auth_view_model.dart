import 'dart:async';
import 'dart:io';

import 'package:country_ip/country_ip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/fcm_token_service.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/core/utils/helpers/snack_bar_helper.dart';
import 'package:transfusio/src/core/utils/validators/emails_validator.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/set_fcm_device_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/set_new_password_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:transfusio/src/features/dashboard/presentation/view_models/dashboard_view_model.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class AuthViewModel extends GetxController {
  // Services
  final FcmTokenService fcmTokenService;

  // UseCases
  final LoginUseCase loginUseCase;
  final VerifyPasswordUseCase verifyPasswordUseCase;
  final SetFcmDeviceUseCase setFcmDeviceUseCase;
  final SendOtpUseCase sendOtpUseCase;
  final RegisterUseCase registerUseCase;
  final SetNewPasswordUseCase setNewPasswordUseCase;

  // States
  RxBool isLoading = false.obs;
  RxString phone = "".obs;
  RxString countryCode = "+228".obs;
  RxString countryName = "Togo".obs;

  RxBool isPhone = false.obs;

  RxBool emailIsValid = false.obs;

  RxBool isPasswordEmpty = true.obs;
  RxBool isConfirmPasswordEmpty = true.obs;

  RxBool isOtpFieldIsField = false.obs;

  Rx<File?> userAvatar = Rx(null);

  // Form's Controllers
  Rx<GlobalKey<FormState>> keyForm = GlobalKey<FormState>().obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  TextEditingController paswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();
  TextEditingController fifthController = TextEditingController();
  TextEditingController sixthController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // Otp Counter
  Rx<Timer?> timer = Timer(Duration.zero, () {}).obs;
  RxInt remainingSeconds = 60.obs;
  RxBool canResendOtp = false.obs;

  AuthViewModel({
    required this.loginUseCase,
    required this.verifyPasswordUseCase,
    required this.setFcmDeviceUseCase,
    required this.registerUseCase,
    required this.fcmTokenService,
    required this.sendOtpUseCase,
    required this.setNewPasswordUseCase,
  });

  Future<void> getCountryInfos() async {
    final countryIpResponse = await CountryIp.find();

    if (countryIpResponse == null) {
      countryCode.value = "+228";
      countryName.value = "Togo";

      return;
    }
  }

  void setPhone(String value) => phone.value = value;

  void setCountryCode(String value) => countryCode.value = value;

  void setCountryName(String value) => countryName.value = value;

  void setIsLoading(bool value) => isLoading.value = value;

  void setIsPhone(bool value) => isPhone.value = value;

  void setEmailIsValid(bool value) => emailIsValid.value = value;

  void setIsPasswordEmpty(bool value) => isPasswordEmpty.value = value;

  void setIsConfirmPasswordEmpty(bool value) =>
      isConfirmPasswordEmpty.value = value;

  void setIsOtpFieldIsField(bool value) => isOtpFieldIsField.value = value;

  Future<void> login(context) async {
    if (isPhone.isTrue && phone.value.length < 8) {
      SnackBarHelper.showCustomSnackBar(
        context,
        "Veuillez renseigner un numéro de téléphone valide.",
      );
    } else if (isPhone.isFalse &&
        emailValidator(emailController.text) != null) {
      SnackBarHelper.showCustomSnackBar(
        context,
        "Veuillez renseigner une adresse mail valide.",
      );
    } else {
      String? phoneNumber;
      String? email;

      String authValue = "";

      // Check if it's an email or a phone and save it in authValue's variable
      if (isPhone.isTrue && phone.value.isNotEmpty) {
        phoneNumber = "${countryCode.value}${phone.value}";
        authValue = phoneNumber;
      } else if (isPhone.isFalse &&
          emailValidator(emailController.text) == null) {
        email = emailController.text;
        authValue = email;
      }

      setIsLoading(true);

      final DataState<LoginResponse> result = await loginUseCase.call(
        UserLoginParams(phone: phoneNumber, email: email),
      );

      if (result is DataSuccess<LoginResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          AppStorage.instance.setBool(key: "isPhone", value: isPhone.value);
          // Save Auth Value
          AppStorage.instance.setString(key: "authValue", value: authValue);
          AppStorage.instance.setNum(
            key: "userId",
            value: result.data!.user!.id!,
          );
          AppRouter.router.push(AppRouter.passwordPage);
        } else {
          if (result.data!.otp != null) {
            // Save Otp
            AppStorage.instance.setString(key: "otp", value: result.data!.otp!);
            AppStorage.instance.setBool(key: "isPhone", value: isPhone.value);
            // Save Auth Value
            AppStorage.instance.setString(key: "authValue", value: authValue);
            AppStorage.instance.setString(
              key: "countryName",
              value: countryName.value,
            );
            SnackBarHelper.showCustomSnackBar(
              context,
              result.data!.message!,
              backgroundColor: Colors.green,
            );
            AppRouter.router.push(AppRouter.otpPage, extra: true);
          } else {
            SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
          }
        }

        setIsLoading(false);
      } else if (result is DataFailed<LoginResponse>) {
        setIsLoading(false);
        SnackBarHelper.showCustomSnackBar(context, result.error!.message);
      }
    }
  }

  Future<void> verifyPassword(context) async {
    if (keyForm.value.currentState!.validate()) {
      setIsLoading(true);

      final DataState<LoginResponse> result = await verifyPasswordUseCase.call(
        UserVerifyPasswordParams(
          id: AppStorage.instance.getNum("userId").toInt(),
          password: paswordController.text,
        ),
      );

      if (result is DataSuccess<LoginResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          _handleLoginSuccess(result.data!);
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

  Future<void> forgotPassword(context) async {
    await sendCode(context, isFirst: false);
    AppRouter.router.push(AppRouter.otpPage, extra: false);
  }

  Future<void> createNewPassword(context) async {
    if (keyForm.value.currentState!.validate()) {
      if (paswordController.text != confirmPasswordController.text) {
        SnackBarHelper.showCustomSnackBar(
          context,
          "Les mots de passe ne correspondent pas",
        );
        return;
      }
      setIsLoading(true);

      // Check if user used phone or email when login
      bool isPhoneChoosen = AppStorage.instance.getBool("isPhone");
      String? phoneNumber;
      String? email;

      if (isPhoneChoosen) {
        // If user used phone, so get the value
        phoneNumber = AppStorage.instance.getString("authValue");
      } else {
        // If user used email, so get the value
        email = AppStorage.instance.getString("authValue");
      }

      final DataState<BasicResponse> result = await setNewPasswordUseCase.call(
        SetNewPasswordParams(
          email: email,
          phone: phoneNumber,
          password: paswordController.text,
        ),
      );

      if (result is DataSuccess<BasicResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          SnackBarHelper.showCustomSnackBar(
            context,
            "Mot de passe réinitialisé avec succès.",
            backgroundColor: Colors.green,
          );
          Future.delayed(const Duration(seconds: 1), () {
            AppRouter.router.go(AppRouter.loginPage);
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

  Future<void> _handleLoginSuccess(LoginResponse response) async {
    AppStorage.instance
      ..setString(key: userTokenAuth, value: response.token!)
      ..setInstance(key: userData, value: response.user)
      ..setNum(key: "scanDiffMinutes", value: 50);

    AppServices.instance
      ..checkUser()
      ..checkUserToken();

    debugPrint("Redirect to dashboard");

    locator<DashboardViewModel>().setCurrentIndex(0);

    await setTokenFcm(fcmTokenService.fcmToken!);
  }

  // Set Fcm device
  Future<void> setTokenFcm(String deviceToken) async {
    final DataState<BasicResponse> result = await setFcmDeviceUseCase.call(
      deviceToken,
    );
    if (result is DataSuccess<BasicResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");

      AppRouter.router.go(AppRouter.dashboardPage);
    } else if (result is DataFailed<BasicResponse>) {
      debugPrint("Bad response => ${result.error!.message}");
    }
  }

  void checkIfOtpFieldisFilled(context) {
    if (firstController.text.isNotEmpty &&
        secondController.text.isNotEmpty &&
        thirdController.text.isNotEmpty &&
        fourthController.text.isNotEmpty &&
        fifthController.text.isNotEmpty &&
        sixthController.text.isNotEmpty) {
      setIsOtpFieldIsField(true);
    } else {
      setIsOtpFieldIsField(false);
    }
  }

  void startCountdown() {
    remainingSeconds.value = 60;
    canResendOtp.value = false;

    timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        timer.cancel();
        canResendOtp.value = true;
      }
    });
  }

  sendCode(context, {bool isFirst = true}) async {
    firstController.clear();
    secondController.clear();
    thirdController.clear();
    fourthController.clear();
    fifthController.clear();
    sixthController.clear();

    setIsLoading(true);

    // Check if user used phone or email when login
    bool isPhoneChoosen = AppStorage.instance.getBool("isPhone");
    String? phoneNumber;
    String? email;

    if (isPhoneChoosen) {
      // If user used phone, so get the value
      phoneNumber = AppStorage.instance.getString("authValue");
    } else {
      // If user used email, so get the value
      email = AppStorage.instance.getString("authValue");
    }

    final DataState<LoginResponse> result = await sendOtpUseCase.call(
      UserLoginParams(phone: phoneNumber, email: email, isNew: isFirst),
    );

    if (result is DataSuccess<LoginResponse>) {
      debugPrint("Good response => ${result.data!.toJson()}");
      if (result.data!.status!) {
        AppStorage.instance.setString(key: "otp", value: result.data!.otp!);
        SnackBarHelper.showCustomSnackBar(
          context,
          result.data!.message!,
          backgroundColor: Colors.green,
        );
        startCountdown(); // Start countdown
      } else {
        SnackBarHelper.showCustomSnackBar(context, result.data!.message!);
      }
      setIsLoading(false);
    } else if (result is DataFailed<LoginResponse>) {
      setIsLoading(false);
      SnackBarHelper.showCustomSnackBar(context, result.error!.message);
    }
  }

  void verifyOtp(context, bool isLogin) {
    String codeTapped =
        firstController.text +
        secondController.text +
        thirdController.text +
        fourthController.text +
        fifthController.text +
        sixthController.text;

    // Check if code is correct
    if (AppStorage.instance.getString("otp") == codeTapped) {
      if (isLogin) {
        AppStorage.instance.setBool(key: "otpVerified", value: true);

        AppRouter.router.push(AppRouter.registerPage);
      } else {
        AppRouter.router.push(AppRouter.setNewPasswordPage);
      }
    } else {
      SnackBarHelper.showCustomSnackBar(
        context,
        "Désolé, le code est incorrect!",
      );
    }
  }

  Future<void> register(context) async {
    if (keyForm.value.currentState!.validate()) {
      // Check if user used phone or email when login
      bool isPhoneChoosen = AppStorage.instance.getBool("isPhone");
      String? phoneNumber;
      String? email;
      // String countryName = AppStorage.instance.getString("countryName");

      if (isPhoneChoosen) {
        // If user used phone, so get the value and check if email is not empty in register's form
        phoneNumber = AppStorage.instance.getString("authValue");
        if (emailController.text.isNotEmpty) {
          email = emailController.text;
        }
      } else {
        // If user used email, so get the value and check if phone is not empty in register's form
        email = AppStorage.instance.getString("authValue");
        if (phone.isNotEmpty) {
          phoneNumber = "${countryCode.value}${phone.value}";
        }
      }

      Map<String, dynamic> userData = {
        'email': email,
        'phone': phoneNumber,
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'password': paswordController.text.trim(),
        'email_verify': isPhoneChoosen ? false : true,
        'phone_verify': isPhoneChoosen ? true : false,
        'address': "",
      };
      if (userAvatar.value != null) {
        userData['avatar'] = await dio.MultipartFile.fromFile(
          userAvatar.value!.path,
          filename: userAvatar.value!.path.split('/').last,
        );
      }

      final dio.FormData registerData = dio.FormData.fromMap(userData);

      setIsLoading(true);

      final DataState<LoginResponse> result = await registerUseCase.call(
        UserRegisterParams(formData: registerData),
      );

      if (result is DataSuccess<LoginResponse>) {
        debugPrint("Good response => ${result.data!.toJson()}");
        if (result.data!.status!) {
          _handleLoginSuccess(result.data!);
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
}
