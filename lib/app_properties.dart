import 'package:flutter/material.dart';

// Custom color definitions
const Color yellow = Color.fromARGB(255, 8, 64, 219);
const Color mediumYellow = Color.fromARGB(255, 26, 91, 233);
const Color darkYellow = Color.fromARGB(255, 39, 39, 235);
const Color primaryColor = Color.fromRGBO(75, 128, 233, 1);
const Color buttonColor = Color.fromARGB(251, 87, 62, 62);
const Color darkGrey = Color.fromARGB(255, 43, 42, 42);
const Color cardColor = Color.fromARGB(189, 191, 191, 219);
const Color white = Colors.white;

// Define your gradients
const LinearGradient mainButton = LinearGradient(
  colors: [
    Color.fromRGBO(236, 60, 3, 1),
    Color.fromRGBO(234, 60, 3, 1),
    Color.fromRGBO(216, 78, 16, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

// Define shadows
const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6),
];

// Screen aware size utility function
double screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

// Function to get heart color based on the current theme
Color heartColor(BuildContext context) {
  // Use Material Theme's brightness to determine the heart color
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.red[400]! // Use Material's red color for dark theme
      : Colors.red[400]!; // Use Material's red color for light theme
}
