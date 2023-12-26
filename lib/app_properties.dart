import 'package:canton_ui/config/themes/dark_theme/dark_color_palette.dart';
import 'package:canton_ui/config/themes/light_theme/light_color_palette.dart';
import 'package:flutter/material.dart';

const Color yellow = Color.fromARGB(255, 8, 64, 219);
const Color mediumYellow = Color.fromARGB(255, 26, 91, 233);
const Color darkYellow = Color.fromARGB(255, 39, 39, 235);
const Color primaryColor = Color.fromRGBO(75, 128, 233, 1);
const Color buttonColor = Color.fromARGB(251, 87, 62, 62);
const Color darkGrey = Color.fromARGB(255, 43, 42, 42);
const Color cardColor = Color.fromARGB(189, 191, 191, 219);
const Color white = Colors.white;

const LinearGradient mainButton = LinearGradient(
  colors: [
    Color.fromRGBO(236, 60, 3, 1),
    Color.fromRGBO(234, 60, 3, 1),
    Color.fromRGBO(216, 78, 16, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

Color heartColor(BuildContext context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return CantonDarkColors.red[400]!;
  }
  return CantonColors.red[400]!;
}
