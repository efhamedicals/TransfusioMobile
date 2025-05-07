import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/app.dart';
import 'package:transfusio/src/core/services/init_app_service.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initAppServices();
      runApp(const TransfusioApp());

      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
        FlutterError.dumpErrorToConsole(details);
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      };
    },
    (error, stackTrace) {
      debugPrint('Exception non capturée : $error');
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    },
  );
}
