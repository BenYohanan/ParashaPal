import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:pocket_siddur/app_properties.dart';

import 'package:pocket_siddur/helpers/helpers.dart';

class NotificationService {
  final cron = Cron();
  var helper = Helper();
  Random random = Random();

  Future<void> initializeNotification() async {
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
            importance: NotificationImportance.High),
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
    cron.schedule(Schedule.parse('0 9 * * 1'), () async {
      await _scheduleNotification(
        4,
        'daily_notification_channel',
        'Shalom Aleichem!',
        selectedDailyNotificationTextMonday,
      );
    });

    // Schedule notifications for Tuesday (ID: 4)
    String selectedDailyNotificationTextTuesday =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 2'), () async {
      await _scheduleNotification(
        5,
        'daily_notification_channel',
        'Shalom Aleichem',
        selectedDailyNotificationTextTuesday,
      );
    });

    // Schedule notifications for Wednesdays (ID: 5)
    String selectedDailyNotificationTextWednesdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 3'), () async {
      await _scheduleNotification(
        6,
        'daily_notification_channel',
        'Shalom Aleichem',
        selectedDailyNotificationTextWednesdays,
      );
    });

    // Schedule notifications for Thursdays (ID: 7)
    String selectedDailyNotificationTextThursdays =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 4'), () async {
      await _scheduleNotification(
        7,
        'daily_notification_channel',
        'Shalom Aleichem',
        selectedDailyNotificationTextThursdays,
      );
    });

    // Schedule notifications for Fridays (ID: 0)
    String selectedPreparationDayNotificationText =
        helper.preparationDayNotificationTextOptions[random.nextInt(
      helper.preparationDayNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 5'), () async {
      await _scheduleNotification(
        0,
        'daily_notification_channel',
        'Preparation Day',
        selectedPreparationDayNotificationText,
      );
    });
    String selectedNotificationText =
        helper.shabbathErevNotificationTextOptions[random.nextInt(
      helper.shabbathErevNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 17 * * 5'), () async {
      await _scheduleNotification(
        1,
        'daily_notification_channel',
        'Shabbath Erev',
        selectedNotificationText,
      );
    });

    // Schedule notifications for Saturdays (ID: 2)
    String selectedShabbathDayNotificationText =
        helper.shabbathDayNotificationTextOptions[random.nextInt(
      helper.shabbathDayNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 6'), () async {
      await _scheduleNotification(
        2,
        'daily_notification_channel',
        'Yom Shabbath',
        selectedShabbathDayNotificationText,
      );
    });

    // Schedule notifications for Sundays (ID: 3)
    String selectedSundayNotificationText =
        helper.sundayMorningNotificationTextOptions[random.nextInt(
      helper.sundayMorningNotificationTextOptions.length,
    )];
    cron.schedule(Schedule.parse('0 9 * * 7'), () async {
      await _scheduleNotification(
        3,
        'daily_notification_channel',
        'Shavua Tov',
        selectedSundayNotificationText,
      );
    });
  }

  Future<void> _scheduleNotification(
    int id,
    String channelKey,
    String title,
    String body,
  ) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          notificationLayout: NotificationLayout.BigText),
    );
  }
}
