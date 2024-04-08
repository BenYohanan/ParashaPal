import 'package:flutter/material.dart';
import 'package:pocket_siddur/screens/blessing/blessingScreen.dart';

import 'screens/home/home.dart';
import 'screens/parasha/parashaScreen.dart';
import 'screens/siddur/siddurScreen.dart';

final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => MainPage(),
  ParaShaScreen.routeName: (context) => ParaShaScreen(),
  SiddurScreen.routeName: (context) => SiddurScreen(),
  BlessingScreen.routeName: (context) => BlessingScreen(),
};
