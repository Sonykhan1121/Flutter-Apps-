import 'package:flutter/material.dart';
import 'package:weather_app/themes/themes.dart';

class ThemeProvider with ChangeNotifier{

  ThemeData _themeData;
  bool _isDarkMode;

  ThemeProvider({bool isDarkMode = false})
  : _isDarkMode = isDarkMode,_themeData = isDarkMode? AppThemes.darkTheme:AppThemes.lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode? AppThemes.darkTheme:AppThemes.lightTheme;
    notifyListeners();
  }

  void setCustomTheme(ThemeData theme)
  {
    _themeData = theme;
    notifyListeners();
  }

}