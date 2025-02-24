import 'package:flutter/material.dart';
import 'appcolors.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.myColor,
      // Used for the app's primary interactive elements
      colorScheme: ColorScheme.fromSwatch().copyWith(

        primary: AppColors.myColor,
        // Primary color for theme
        onPrimary: AppColors.black,
        // Primary text/icon color on top of primary color
        secondary: AppColors.myColordue,
        // Secondary color for theme
        onSecondary: AppColors.black,
        // Text color on secondary color backgrounds
        background: AppColors.myColordue,
        // App background color
        onBackground: AppColors.black, // Text color on background color
      ),
      scaffoldBackgroundColor: AppColors.myColordue,
      // Background color of Scaffold widgets
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.myColor, // Background color of the AppBar
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        // Icon theme data for AppBar icons
        iconTheme: IconThemeData(color: AppColors.black),
        actionsIconTheme: IconThemeData(
          color: AppColors.black,
        ), // Specifically for AppBar actions
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        titleMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        labelLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: AppColors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),

    );
  }
}
