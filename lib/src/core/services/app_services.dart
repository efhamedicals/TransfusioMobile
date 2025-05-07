import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/services/storage/app_storage.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';
import 'package:transfusio/src/shared/data/models/lang_model.dart';

class AppServices extends GetxService {
  static AppServices get instance => Get.find();

  String? codeLang;

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  String? authTokenUser;

  Future<AppServices> init() async {
    await AppStorage.instance.storage;
    await initLangUser();
    await checkUser();
    await checkUserToken();
    return this;
  }

  initLangUser() async {
    String deviceCode = Get.deviceLocale!.languageCode;
    var isLang = AppStorage.instance.exist(langUser);

    if (isLang == false) {
      final String response = await rootBundle.loadString(
        'assets/data/lang.json',
      );
      final data = await json.decode(response);

      List<LangModel> listLangApp = List<LangModel>.from(
        data["lang"]?.map((p) => LangModel.fromMap(p)),
      );
      var contain = listLangApp.where((el) => el.code == deviceCode);

      if (contain.isNotEmpty) {
        AppStorage.instance.setString(key: langUser, value: deviceCode);
        codeLang = deviceCode;
      } else {
        AppStorage.instance.setString(key: langUser, value: 'fr');
        codeLang = 'fr';
      }
    } else {
      codeLang = await AppStorage.instance.getDataStorage(langUser);
    }
  }

  Future<void> checkUser() async {
    if (AppStorage.instance.exist(userData)) {
      currentUser.value = UserModel.fromJson(
        json.decode(await AppStorage.instance.getDataStorage(userData)),
      );
      debugPrint("Current user info : ${currentUser.value?.toJson()}");
    } else {
      currentUser.value = null;
    }
  }

  Future<void> checkUserToken() async {
    if (AppStorage.instance.exist(userTokenAuth)) {
      authTokenUser = await AppStorage.instance.getDataStorage(userTokenAuth);
      debugPrint("Token auth user : $authTokenUser");
    } else {
      authTokenUser = "";
    }
  }
}
