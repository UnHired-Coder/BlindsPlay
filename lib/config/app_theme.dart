import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      // Use ColorScheme for comprehensive theming
      colorScheme: appColorScheme, // Use lightColorScheme for light mode

      // Background color for the whole app
      scaffoldBackgroundColor: AppColors.background,

      // Text themes for various text elements
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.heading1, // Larger headings
        headlineMedium: AppTextStyles.heading2, // Secondary heading
        headlineSmall: AppTextStyles.heading3, // Tertiary heading
        bodyLarge: AppTextStyles.bodyText, // Main body text
        bodyMedium: AppTextStyles.bodyTextSmall, // Smaller body text
        bodySmall: AppTextStyles.dialogContent, // Dialog content,
        labelLarge: AppTextStyles.button, // Text style for buttons,
        labelMedium: AppTextStyles.overline, // Smaller overline text
        labelSmall: AppTextStyles.caption, // Caption text
        titleLarge: AppTextStyles.dialogTitle, // Dialog titles
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Background color of ElevatedButton
          foregroundColor: Colors.white, // Text color of ElevatedButton
          textStyle: AppTextStyles.button, // Text style of ElevatedButton
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent, // Border and text color for OutlinedButton
          side: const BorderSide(color: AppColors.accent),
          textStyle: AppTextStyles.button, // Text style of OutlinedButton
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent, // Text color for TextButton
          textStyle: AppTextStyles.button, // Text style of TextButton
        ),
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: AppTextStyles.heading2,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: AppTextStyles.bodyText,
        hintStyle: AppTextStyles.caption,
      ),
    );
  }
}
