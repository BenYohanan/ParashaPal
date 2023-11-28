import 'package:flutter/material.dart';
import 'package:pocket_siddur/provider/provider.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'screens/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProviderService(),
        ),
      ],
      child: MaterialApp(
        title: 'Messianic Siddur',
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat",
        ),
        home: SplashScreen(),
      ),
    );
  }
}
