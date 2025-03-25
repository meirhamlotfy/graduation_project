import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/presentation_logic_holder/bottom_navigation_cubit.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';

import 'get_it_injection.dart';
import 'navigation_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationHelper.onBgNotificationOpen(json.encode(message.data));
}

class NotificationHelper {
  NotificationHelper({this.fcmOnMessage}) {
    _initFCM();
  }

  static final _fcmNotify = FirebaseMessaging.instance;
  static final _localNotify = FlutterLocalNotificationsPlugin();

  final Function? fcmOnMessage;
  bool _init = false;

  Future<void> subscribeToTopic(String topic) async {
    await _fcmNotify.subscribeToTopic("topic_$topic");
  }

  Future<void> unSubscribeToTopic(String topic) async {
    await _fcmNotify.unsubscribeFromTopic("topic_$topic");
  }

  Future<void> _initFCM() async {
    if (_init) return;

    await _fcmNotify.subscribeToTopic('all');
    await _fcmNotify.setAutoInitEnabled(true);
    await _saveFCMToken();
    _onTokenRefresh();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        debugPrint(
          "methodName: 'FirebaseMessaging@onMessage',\n"
          "fileName: 'fcm_manager.dart',\n"
          "response: \${message.data},\n",
          wrapWidth: 512,
        );
      }
      if (fcmOnMessage != null) fcmOnMessage!(message);
      showNotification(message);
    });

    await _fcmNotify.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _localNotify.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationOpen,
    );

    _init = true;
  }

  Future<void> _saveFCMToken() async {
    final token = await _fcmNotify.getToken();
    if (kDebugMode) debugPrint("_fcmToken: $token");
  }

  static Future<void> onBgNotificationOpen(String? x) async {
    try {
      BottomNavigationCubit.get(
              getIt<NavHelper>().navigatorKey.currentState!.context)
          .changeCurrent(2);
      navigateTo(BNBScreen());
    } catch (e) {}
  }

  static Future<void> onNotificationOpen(NotificationResponse? x) async {
    try {
      BottomNavigationCubit.get(
              getIt<NavHelper>().navigatorKey.currentState!.context)
          .changeCurrent(2);
      navigateTo(BNBScreen());
    } catch (e) {}
  }

  void showNotification(RemoteMessage payload) async {
    await _initFCM();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'ELChannelID',
      'ELChannelName',
      channelDescription: 'ELChanelDescription',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _localNotify.show(
      Random().nextInt(999),
      payload.notification?.title ?? '',
      payload.notification?.body ?? '',
      platformChannelSpecifics,
      payload: json.encode(payload.data),
    );
  }

  Future<void> _onTokenRefresh() async {}
}
