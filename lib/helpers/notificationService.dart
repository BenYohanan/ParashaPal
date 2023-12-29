import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
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
    await notificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: (payload) async {
      onNotification.add(payload);
    });
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

  Future<void> scheduleNotifications() async {
    var helper = Helper();
    var flutterLocalNotificationsPlugin =
        NotificationService.notificationsPlugin;
    Random random = Random();
    // Schedule notifications for Mondays (ID: 4)
    String selectedDailyNotificationTextMonday =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      4,
      'Shalom Aleichem',
      selectedDailyNotificationTextMonday,
      _nextInstanceOfDay(9, 1),
    );
    // Schedule notifications for Tuesday (ID: 4)
    String selectedDailyNotificationTextTuesday =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      5,
      'Shalom Aleichem',
      selectedDailyNotificationTextTuesday,
      _nextInstanceOfDay(9, 2),
    );
    // Schedule notifications for Wednesdays (ID: 5)
    String selectedDailyNotificationTextWednesdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      6,
      'Shalom Aleichem',
      selectedDailyNotificationTextWednesdays,
      _nextInstanceOfDay(9, 3),
    );
    // Schedule notifications for Thursdays (ID: 7)
    String selectedDailyNotificationTextThursdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      7,
      'Shalom Aleichem',
      selectedDailyNotificationTextThursdays,
      _nextInstanceOfDay(9, 4),
    );

    // Schedule notifications for Fridays (ID: 0)
    String selectedPreparationDayNotificationText =
        helper.preparationDayNotificationTextOptions[random.nextInt(
      helper.preparationDayNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      0,
      'Preparation Day',
      selectedPreparationDayNotificationText,
      _nextInstanceOfDay(9, 5),
    );
    String selectedNotificationText =
        helper.shabbathErevNotificationTextOptions[random.nextInt(
      helper.shabbathErevNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      1,
      'Shabbath Erev',
      selectedNotificationText,
      _nextInstanceOfDay(17, 5),
    );

    // Schedule notifications for Saturdays (ID: 2)
    String selectedShabbathDayNotificationText =
        helper.shabbathDayNotificationTextOptions[random.nextInt(
      helper.shabbathDayNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      2,
      'Yom Shabbath',
      selectedShabbathDayNotificationText,
      _nextInstanceOfDay(9, 6),
    );

    // Schedule notifications for Sundays (ID: 3)
    String selectedSundayNotificationText =
        helper.sundayMorningNotificationTextOptions[random.nextInt(
      helper.sundayMorningNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      flutterLocalNotificationsPlugin,
      3,
      'Shavua Tov',
      selectedSundayNotificationText,
      _nextInstanceOfDay(9, 7),
    );
  }

  tz.TZDateTime _nextInstanceOfDay(int hour, int dayOfWeek) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      dayOfWeek,
      hour,
      0,
    );

    return scheduledDate;
  }

  Future<void> _scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id_$id',
          'Channel $id',
          channelDescription: 'Daily Notification',
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
