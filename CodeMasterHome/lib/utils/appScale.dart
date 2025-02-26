import 'package:flutter/material.dart';
class AppScale {
  static const double baseWidth = 700; // Set this to your design width

  static double scaleText(double size, BuildContext context) {
    // print("width: ${MediaQuery.of(context).size.width}");
    return size * MediaQuery.of(context).size.width / AppScale.baseWidth;
  }
}
