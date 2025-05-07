import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String channelId = 'high_importance_channel';
const String channelTitle = 'Notification';
const String channelDescription = 'All Notification is Here';
const String channelGroupKey = 'com.transfusio.www';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotification() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      channelId,
      channelTitle,
      description: channelDescription,
      importance: Importance.high,
      showBadge: true,
      playSound: true,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: true,
        );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    //final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future refreshingList() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //refresh event here.
    });
  }

  static void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      refreshingList();
      //router
    }
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
    NotificationResponse notificationResponse,
  ) {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      refreshingList();
      //router
    }
  }

  static void showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          channelId,
          channelTitle,
          channelDescription: channelDescription,
          icon: '@mipmap/launcher_icon',
          ticker: 'ticker',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
          channelShowBadge: true,
          playSound: true,
          ongoing: false,
          //autoCancel: true,
          //groupKey: channelGroupKey,
          setAsGroupSummary: true,
          styleInformation: BigTextStyleInformation(''),
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }

  static void showNotificationLocal(int uid, String title, String body) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          channelId,
          channelTitle,
          channelDescription: channelDescription,
          icon: '@mipmap/launcher_icon',
          ticker: 'ticker',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
          channelShowBadge: true,
          playSound: true,
          ongoing: true,
          autoCancel: false,
          setAsGroupSummary: true,
          styleInformation: BigTextStyleInformation(''),
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      uid,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
