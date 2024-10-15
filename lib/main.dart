import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:pocket_siddur/helpers/location_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_siddur/helpers/notificationService.dart';
import 'routes.dart';
import 'screens/splash/splash_page.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Schedule notifications
    final notificationService = NotificationService();
    notificationService.initializeNotification();
    await notificationService.requestNotificationPermissions();
    await notificationService.scheduleNotifications();

    // Location
    await LocationService().initialize();
    await Location.instance.requestPermission();

    // Storage
    await Hive.initFlutter();
    await Hive.openBox('pocket_siddur');

    runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );
  }, (error, stack) async {
    print('Error: $error\n$stack');
  });
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
            textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}
