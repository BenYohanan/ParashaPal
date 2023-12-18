import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseScreen extends StatefulWidget {
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    navigateToLastPage();
  }

  void navigateToLastPage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String lastRoute = prefs.getString('last_route') ?? "";

      if (lastRoute != null && lastRoute.isNotEmpty) {
        _navigatorKey.currentState?.pushReplacementNamed(lastRoute);
      }
    } catch (e) {
      // Handle errors, e.g., if SharedPreferences cannot be read
      print('Error navigating to last page: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => Container());
      },
    );
  }
}
