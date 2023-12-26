import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:pocket_siddur/helpers/helpers.dart';
import 'package:pocket_siddur/helpers/location_service.dart';
import 'package:pocket_siddur/helpers/notificationService.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes.dart';
import 'screens/splash/splash_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeApp();
    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stack) async {
    print('Error: $error\n$stack');
  });
}

Future<void> initializeApp() async {
  await LocationService().initialize();
  await Location.instance.requestPermission();
  await Hive.initFlutter();
  await Hive.openBox('pocket_siddur');

  final notificationService = NotificationService();
  await NotificationService.initNotification(initSchedule: true);
  await notificationService.requestNotificationPermissions();

  listenNotification();
  tz.initializeTimeZones();

  // Schedule notifications
  await _scheduleDailyNotifications(notificationService);
}

Random random = Random();

void listenNotification() => NotificationService.onNotification;

Future<void> _scheduleDailyNotifications(
  NotificationService notificationService,
) async {
  int today = DateTime.now().day;
  var helper = Helper();

  // Schedule notification For every day
  if (![7, 5, 6].contains(today)) {
    String selectedDailyNotificationText =
        helper.dailyNotificationTextOptions[random.nextInt(
      helper.dailyNotificationTextOptions.length,
    )];
    await notificationService.scheduleDailyNotification(
      id: 0,
      dayOfWeek: 1,
      title: 'Shalom Aleichem',
      body: selectedDailyNotificationText,
      payLoad: 'daily_reminder',
    );
  }

  // Schedule notification For Shabbath Erev
  if (today == 5) {
    // Schedule notification at 9 AM
    String selectedPreparationDayNotificationText =
        helper.preparationDayNotificationTextOptions[random.nextInt(
      helper.preparationDayNotificationTextOptions.length,
    )];
    await notificationService.scheduleNotification(
      id: 1,
      title: 'Preparation Day',
      body: selectedPreparationDayNotificationText,
      payLoad: 'friday_morning_reminder',
    );

    // Schedule notification at 5 PM
    String selectedNotificationText =
        helper.shabbathErevNotificationTextOptions[random.nextInt(
      helper.shabbathErevNotificationTextOptions.length,
    )];
    await notificationService.scheduleNotification(
      id: 2,
      title: 'Shabbath Erev',
      body: selectedNotificationText,
      payLoad: 'friday_evening_reminder',
    );
  }

  // Schedule notification For Yom Shabbath
  if (today == 6) {
    String selectedShabbathDayNotificationText =
        helper.shabbathDayNotificationTextOptions[random.nextInt(
      helper.shabbathDayNotificationTextOptions.length,
    )];
    await notificationService.scheduleDailyNotification(
      id: 3,
      dayOfWeek: 6,
      title: 'Yom Shabbath',
      body: selectedShabbathDayNotificationText,
      payLoad: 'shabbath_reminder',
    );
  }

  // Schedule notification For Shavua Tov
  if (today == 7) {
    String selectedSundayNotificationText =
        helper.sundayMorningNotificationTextOptions[random.nextInt(
      helper.sundayMorningNotificationTextOptions.length,
    )];
    await notificationService.scheduleDailyNotification(
      id: 4,
      dayOfWeek: 7,
      title: 'Shavua Tov',
      body: selectedSundayNotificationText,
      payLoad: 'shavua_tov_reminder',
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Messianic Siddur',
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: SplashScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
    );
  }
}
