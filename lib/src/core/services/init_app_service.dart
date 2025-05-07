import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:transfusio/firebase_options.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/utils/logs/app_log.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/translations/app_translation.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';
import 'package:logging/logging.dart';
import 'notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('A background message just showed up :  ${message.toMap()}');
  }
  NotificationService.showNotification(message);
  NotificationService.refreshingList();
}

Future<void> initAppServices() async {
  Get.engine;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initializeNotification();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await Get.putAsync(() => AppServices().init(), permanent: true);
  setupLocator(AppRouter.router);
  await locator<ThemeViewModel>().getThemeModeFromStore();
  Get.addTranslations(AppTranslations().keys);
  Get.updateLocale(Locale(AppServices.instance.codeLang!));
  _initLog();
}

void _initLog() {
  AppLog.init();
  AppLog.setLevel(Level.ALL);
}
