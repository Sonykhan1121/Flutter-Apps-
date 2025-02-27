import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';


class InputThemes {
  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMedium,
        vertical: AppDimensions.spacingMedium,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.errorColor),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      labelStyle: const TextStyle(
        color: AppColors.textSecondaryColor,
        fontSize: AppDimensions.fontSizeSmall,
      ),
      hintStyle: const TextStyle(
        color: AppColors.textLightColor,
        fontSize: AppDimensions.fontSizeSmall,
      ),
    );
  }
}