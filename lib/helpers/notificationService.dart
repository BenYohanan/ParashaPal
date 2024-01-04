import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pocket_siddur/app_properties.dart';

import 'package:pocket_siddur/helpers/helpers.dart';

class NotificationService {
  var helper = Helper();
  Random random = Random();

  void initializeNotification() {
    AwesomeNotifications().initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
          channelKey: 'daily_notification_channel',
          channelName: 'Parashah Pal',
          channelDescription: 'Daily Notification',
          defaultColor: primaryColor,
          ledColor: darkGrey,
          playSound: true,
          enableVibration: true,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  Future<void> requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> scheduleNotifications() async {
    // Schedule notifications for Mondays (ID: 4)
    String selectedDailyNotificationTextMonday =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      4,
      'daily_notification_channel',
      'Shalom Aleichem!',
      selectedDailyNotificationTextMonday,
      1,
      9,
      0,
    );

    // Schedule notifications for Tuesday (ID: 4)
    String selectedDailyNotificationTextTuesday =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      5,
      'daily_notification_channel',
      'Shalom Aleichem',
      selectedDailyNotificationTextTuesday,
      2,
      9,
      0,
    );

    // Schedule notifications for Wednesdays (ID: 5)
    String selectedDailyNotificationTextWednesdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      6,
      'daily_notification_channel',
      'Shalom Aleichem',
      selectedDailyNotificationTextWednesdays,
      3,
      9,
      0,
    );

    // Schedule notifications for Thursdays (ID: 7)
    String selectedDailyNotificationTextThursdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      7,
      'daily_notification_channel',
      'Shalom Aleichem',
      selectedDailyNotificationTextThursdays,
      4,
      9,
      0,
    );

    // Schedule notifications for Fridays (ID: 0)
    String selectedPreparationDayNotificationText =
        helper.preparationDayNotificationTextOptions[random.nextInt(
      helper.preparationDayNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      0,
      'daily_notification_channel',
      'Preparation Day',
      selectedPreparationDayNotificationText,
      5,
      9,
      0,
    );
    String selectedNotificationText =
        helper.shabbathErevNotificationTextOptions[random.nextInt(
      helper.shabbathErevNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      1,
      'daily_notification_channel',
      'Shabbath Erev',
      selectedNotificationText,
      5,
      17,
      0,
    );
    // Schedule notifications for Saturdays (ID: 2)
    String selectedShabbathDayNotificationText =
        helper.shabbathDayNotificationTextOptions[random.nextInt(
      helper.shabbathDayNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      2,
      'daily_notification_channel',
      'Yom Shabbath',
      selectedShabbathDayNotificationText,
      6,
      9,
      0,
    );

    // Schedule notifications for Sundays (ID: 3)
    String selectedSundayNotificationText =
        helper.sundayMorningNotificationTextOptions[random.nextInt(
      helper.sundayMorningNotificationTextOptions.length,
    )];
    await _scheduleNotification(
      3,
      'daily_notification_channel',
      'Shavua Tov',
      selectedSundayNotificationText,
      7,
      9,
      0,
    );
  }

  Future<void> _scheduleNotification(
    int id,
    String channelKey,
    String title,
    String body,
    int weekday,
    int hour,
    int minute,
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
      ),
      schedule: NotificationCalendar(
        weekday: weekday,
        hour: hour,
        minute: minute,
        second: 0,
        millisecond: 0,
        allowWhileIdle: true,
      ),
    );
  }
}
