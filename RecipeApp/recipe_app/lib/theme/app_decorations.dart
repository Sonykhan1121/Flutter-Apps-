// lib/theme/decorations.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppDecorations {
  // Box Decorations
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      boxShadow: AppDimensions.defaultShadow,
    );
  }

  static BoxDecoration roundedDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
    );
  }
}