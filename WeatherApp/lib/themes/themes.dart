

import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor:Colors.orange,
    textTheme: TextTheme(

      bodyLarge: TextStyle(color: Colors.black, fontSize: 16.0),
      displayLarge: TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
    ),

  );
  static final darkTheme = ThemeData(
    brightness : Brightness.dark,
    primaryColor: Colors.grey[900],
    hintColor: Colors.purple,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16.0),
      displayLarge: TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold),
  ),
  );

}