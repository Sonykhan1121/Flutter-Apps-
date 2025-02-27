import 'package:flutter/material.dart';
import 'package:recipe_app/theme/ui_component_theme.dart';

import 'app_colors.dart';
import 'app_typography.dart';
import 'button_themes.dart';
import 'input_themes.dart';

class AppTheme {
  // Get ThemeData
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      // Basic Colors
      primaryColor: AppColors.primaryColor,
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme:  ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        background: AppColors.backgroundColor,
        error: AppColors.errorColor,
        surface: AppColors.cardColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryColor,
        onBackground: AppColors.textPrimaryColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      // Typography
      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.getTextTheme(),

      // Component Themes
      appBarTheme: UIComponentThemes.appBarTheme(),
      cardTheme: UIComponentThemes.cardTheme(),
      elevatedButtonTheme: ButtonThemes.elevatedButtonTheme(),
      outlinedButtonTheme: ButtonThemes.outlinedButtonTheme(),
      textButtonTheme: ButtonThemes.textButtonTheme(),
      floatingActionButtonTheme: ButtonThemes.floatingActionButtonTheme(),
      inputDecorationTheme: InputThemes.inputDecorationTheme(),
      chipTheme: UIComponentThemes.chipTheme(),
      tabBarTheme: UIComponentThemes.tabBarTheme(),
      bottomNavigationBarTheme: UIComponentThemes.bottomNavigationBarTheme(),
      dialogTheme: UIComponentThemes.dialogTheme(),
      snackBarTheme: UIComponentThemes.snackBarTheme(),
      dividerTheme: UIComponentThemes.dividerTheme(),

      // Misc
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}