import 'package:flutter/material.dart';
import 'package:pocket_siddur/screens/blessing/blessingsScreen.dart';

import 'screens/home/home.dart';
import 'screens/parasha/parashaScreen.dart';
import 'screens/siddur/siddurScreen.dart';

final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => MainPage(),
  BlessingsScreen.routeName: (context) => BlessingsScreen(),
  ParaShaScreen.routeName: (context) => ParaShaScreen(),
  SiddurScreen.routeName: (context) => SiddurScreen(),
};
