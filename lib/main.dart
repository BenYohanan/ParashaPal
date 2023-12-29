import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:pocket_siddur/helpers/location_service.dart';
import 'package:pocket_siddur/helpers/notificationService.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routes.dart';
import 'screens/splash/splash_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
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
    notificationService.scheduleNotifications();
    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stack) async {
    print('Error: $error\n$stack');
  });
}

void listenNotification() => NotificationService.onNotification;

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
