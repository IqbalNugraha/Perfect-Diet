import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:skiripsi_app/widget/string_custom.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderNotification{
  Future<void> scheduleNotificationSarapan(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    StringCustom stringCustom = StringCustom();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      stringCustom.idNotification,
      stringCustom.sarapanNotification,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('notification'),
      importance: Importance.high,
      priority: Priority.high,
    );

    var not = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      stringCustom.idNotification,
      stringCustom.sarapanNotification,
      tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'))
          .add(const Duration(hours: 8)),
      not,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}