import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';


class ButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonPrimaryColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.buttonDisabledColor,
        disabledForegroundColor: Colors.white70,
        elevation: 2.0,
        textStyle: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLarge,
          vertical: AppDimensions.spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        textStyle: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLarge,
          vertical: AppDimensions.spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMedium,
          vertical: AppDimensions.spacingSmall,
        ),
      ),
    );
  }

  static FloatingActionButtonThemeData floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: Colors.white,
      elevation: 4.0,
      shape: CircleBorder(),
    );
  }

  // Helper methods for common button styles
  static ButtonStyle primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.buttonPrimaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLarge,
        vertical: AppDimensions.spacingMedium,
      ),
      textStyle: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
    );
  }

  static ButtonStyle secondaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.buttonSecondaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLarge,
        vertical: AppDimensions.spacingMedium,
      ),
      textStyle: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
    );
  }
}