import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/services/fcm_token_service.dart';
import 'package:transfusio/src/core/services/notifications.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/app_theme.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/themes/overlay/app_overlay.dart';
import 'package:transfusio/src/core/translations/dictionary.dart';
import 'package:transfusio/src/core/utils/global_config.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';
import 'package:upgrader/upgrader.dart';

class TransfusioApp extends StatefulWidget {
  const TransfusioApp({super.key});

  @override
  State<TransfusioApp> createState() => _TransfusioAppState();
}

class _TransfusioAppState extends State<TransfusioApp>
    with WidgetsBindingObserver {
  late ThemeViewModel themeViewModel;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    themeViewModel = locator<ThemeViewModel>();
    themeViewModel.addListener(_onThemeChanged);
    WidgetsBinding.instance.addObserver(this);

    //notification get & fetch data
    _fetchAndProcessFcmToken();
    _setupMessageListeners();
    _handleInitialMessage();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchAndProcessFcmToken() async {
    String? tokenFcm = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token User: $tokenFcm');
    locator<FcmTokenService>().setFcmToken(tokenFcm!);
  }

  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'onMessage notification is -> title : ${message.notification!.title}',
      );
      NotificationService.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Just received a notification when app is opened');
      //navigate
    });
  }

  Future<void> _handleInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // NotificationService.refreshingList();
      if (!mounted) return;
    }
  }

  @override
  void dispose() {
    themeViewModel.removeListener(_onThemeChanged);
    WidgetsBinding.instance.removeObserver(this);
    streamSubscription?.cancel();
    controllerData.close();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    locator<ThemeViewModel>().getThemeModeFromStore();
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('didChangeAppLifecycleState: $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      shouldPopScope: () => true,
      upgrader: Upgrader(messages: UpgraderMessages(code: 'fr')),
      dialogStyle:
          Platform.isAndroid
              ? UpgradeDialogStyle.material
              : UpgradeDialogStyle.cupertino,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder:
            (_, child) => ValueListenableBuilder<ThemeMode>(
              valueListenable: themeViewModel.themeModeNotifier,
              builder: (context, themeMode, child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value:
                      themeViewModel.isDarkModeOn
                          ? AppUiOverlay.dark
                          : AppUiOverlay.light,
                  child:
                      isLoading
                          ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.secondaryColor,
                            ),
                          )
                          : MaterialApp.router(
                            key: navigatorKey,
                            title: $dict.global.appName,
                            debugShowCheckedModeBanner: false,
                            themeMode: themeMode,
                            theme: AppTheme.light(context),
                            darkTheme: AppTheme.dark(context),
                            routerConfig: AppRouter.router,
                            localizationsDelegates: const [
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                            ],
                            locale: Locale(AppServices.instance.codeLang!),
                          ),
                );
              },
            ),
      ),
    );
  }
}
