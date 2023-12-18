import 'package:pocket_siddur/app_properties.dart';
import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = Colors.white);
    canvas.drawRect(
      Rect.fromLTRB(width - (width / 3), 0, width, height),
      Paint()..color = primaryColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SiddurBackground extends CustomPainter {
  SiddurBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = darkGrey);
    canvas.drawRect(
      Rect.fromLTRB(width - (width / 3), 0, width, height),
      Paint()..color = darkGrey,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
