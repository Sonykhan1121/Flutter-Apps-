import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppTypography {
  static const String fontFamily = 'Poppins';

  // Text styles
  static TextStyle get headingStyle => const TextStyle(
    fontSize: AppDimensions.fontSizeXXLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle get subheadingStyle => const TextStyle(
    fontSize: AppDimensions.fontSizeLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle get bodyStyle => const TextStyle(
    fontSize: AppDimensions.fontSizeMedium,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle get captionStyle => const TextStyle(
    fontSize: AppDimensions.fontSizeSmall,
    color: AppColors.textSecondaryColor,
  );

  // Get text theme
  static TextTheme getTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppDimensions.fontSizeHeadline,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        color: AppColors.textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        color: AppColors.textPrimaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: AppDimensions.fontSizeXSmall,
        color: AppColors.textSecondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
    );
  }
}