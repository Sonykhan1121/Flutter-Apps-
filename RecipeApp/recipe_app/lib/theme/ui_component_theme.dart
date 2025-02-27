
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';


class UIComponentThemes {
  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0.0,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static CardTheme cardTheme() {
    return CardTheme(
      color: AppColors.cardColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      margin: const EdgeInsets.all(AppDimensions.spacingSmall),
    );
  }

  static ChipThemeData chipTheme() {
    return ChipThemeData(
      backgroundColor: Colors.grey.shade100,
      disabledColor: Colors.grey.shade300,
      selectedColor: AppColors.primaryColor.withOpacity(0.2),
      secondarySelectedColor: AppColors.secondaryColor.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSmall,
        vertical: AppDimensions.spacingXSmall,
      ),
      labelStyle: const TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: AppDimensions.fontSizeSmall,
      ),
      secondaryLabelStyle: const TextStyle(
        color: AppColors.secondaryColor,
        fontSize: AppDimensions.fontSizeSmall,
      ),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
    );
  }

  static TabBarTheme tabBarTheme() {
    return const TabBarTheme(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.textSecondaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static BottomNavigationBarThemeData bottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.textSecondaryColor,
      selectedLabelStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeXSmall,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeXSmall,
      ),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    );
  }

  static DialogTheme dialogTheme() {
    return DialogTheme(
      backgroundColor: AppColors.cardColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
    );
  }

  static SnackBarThemeData snackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: AppColors.textPrimaryColor,
      contentTextStyle: const TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: AppDimensions.fontSizeSmall,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  static DividerThemeData dividerTheme() {
    return const DividerThemeData(
      color: AppColors.borderColor,
      thickness: 1.0,
      space: AppDimensions.spacingMedium,
    );
  }
}
