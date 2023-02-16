import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/ui/pages/notification_screen.dart';

import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializedNotification() async {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  requestIOSPermessions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          sound: true,
          alert: true,
          badge: true,
        );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(NotificationScreen(payload: payload!));
  }

  displatNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    DarwinNotificationDetails darwindNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwindNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'Default_Sound');
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body!));
  }
}
