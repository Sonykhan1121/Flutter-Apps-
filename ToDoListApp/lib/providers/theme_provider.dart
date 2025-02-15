import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  Color _accentColor = Colors.deepPurple; // Default accent color

  ThemeProvider({bool isDarkMode = false})
      : _themeData = isDarkMode ? ThemeData.dark() : ThemeData.light() {
    // Initialize the theme with the default accent color
    _themeData = _themeData.copyWith(
      colorScheme: _themeData.colorScheme.copyWith(
        primary: _accentColor,
        secondary: _accentColor,
      ),
    );
  }

  ThemeData get themeData => _themeData;

  // Getter for accent color
  Color get accentColor => _accentColor;

  // Check if the current theme is dark mode
  bool get isDarkMode => _themeData.brightness == Brightness.dark;

  // Toggle between light and dark themes
  void toggleTheme() {
    _themeData = isDarkMode ? ThemeData.light() : ThemeData.dark();
    _applyAccentColor(); // Reapply the accent color after toggling the theme
    notifyListeners();
  }

  // Set a custom accent color
  void setAccentColor(Color color) {
    _accentColor = color;
    _applyAccentColor();
    notifyListeners();
  }

  // Reset all theme settings to default
  void resetSettings() {
    _accentColor = Colors.deepPurple; // Reset to default accent color
    _themeData = ThemeData.light(); // Reset to light theme
    _applyAccentColor();
    notifyListeners();
  }

  // Helper method to apply the accent color to the current theme
  void _applyAccentColor() {
    _themeData = _themeData.copyWith(
      colorScheme: _themeData.colorScheme.copyWith(
        primary: _accentColor,
        secondary: _accentColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _accentColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _accentColor,
      ),
    );
  }
}