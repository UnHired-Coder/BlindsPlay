import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF242423);
  static const Color secondary = Color(0xFF333533);
  static const Color accent = Color(0xFFF5CB5C);
  static const Color background = Color(0xFFE8EDDF);
  static const Color surface = Color(0xFFCFDBD5);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF4F772D);

  // Additional colors for text
  static const Color error = Color(0xFFD15353); // Red for errors
  static const Color success = Color(0xFF77EA77); // Green for success
  static const Color grey = Color(0xFF9E9E9E); // Grey for captions
  static const Color greyDark = Color(0xFF616161); // Darker grey for over line
}


const ColorScheme appColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  surface: AppColors.surface,
  onSurface: AppColors.primary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
);
