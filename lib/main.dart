import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes.dart';
import 'screens/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationService().initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> getLocation(BuildContext context) async {
    final provider = Provider.of<ProviderService>(context, listen: false);
    var location = await LocationService().getPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude!,
      location.longitude!,
    );
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark first = placemarks.first;
      String locationName =
          "${first.administrativeArea}, ${first.locality}, ${first.country}";
      provider.updateLocation(
        locationName,
        location.latitude!,
        location.longitude!,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messianic Siddur',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[
        MyRouteObserver(),
      ],
      routes: routes,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}

class MyRouteObserver extends RouteObserver {
  void saveLastRoute(Route lastRoute) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_route', lastRoute.settings.name ?? "");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    saveLastRoute(route);
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    saveLastRoute(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    saveLastRoute(route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    saveLastRoute(newRoute!);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
