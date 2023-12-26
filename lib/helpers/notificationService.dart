import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<dynamic>();
  static Future initNotification({bool initSchedule = true}) async {
    const android = AndroidInitializationSettings(
      'drawable/logo',
    );

    var settings = InitializationSettings(android: android);
    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotification.add(payload);
      },
    );
    if (initSchedule) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  Future requestNotificationPermissions() async {
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  static Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channel description',
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    await notificationsPlugin.cancel(id);
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(9), // 9 AM
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    await notificationsPlugin.zonedSchedule(
      id + 1,
      title,
      body,
      _nextInstanceOfTime(17), // 5PM
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future scheduleDailyNotification({
    int? id,
    int? dayOfWeek,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    await notificationsPlugin.cancel(id!);
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfDay(dayOfWeek!, 9),
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate = scheduledDate.add(const Duration(
            days: 1,
          ))
        : scheduledDate;
  }

  static tz.TZDateTime _nextInstanceOfDay(int dayOfWeek, int hour) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      dayOfWeek,
      hour,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate = scheduledDate.add(const Duration(
            days: 1,
          ))
        : scheduledDate;
  }
}
