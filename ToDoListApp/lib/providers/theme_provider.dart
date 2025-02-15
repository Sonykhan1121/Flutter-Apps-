import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light(); // Default to light theme

  ThemeData get themeData => _themeData;

  // Define isDarkMode based on the current theme
  bool get isDarkMode => _themeData.brightness == Brightness.dark;

  void toggleTheme() {
    if (_themeData.brightness == Brightness.light) {
      _themeData = ThemeData.dark(); // Switch to dark theme
    } else {
      _themeData = ThemeData.light(); // Switch to light theme
    }
    notifyListeners(); // Notify listeners about the theme change
  }
}
