import 'package:flutter/material.dart';
import 'colors.dart'; // Import your color definitions

class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );


  // Body Text
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
  );

  static const TextStyle bodyTextSmall = TextStyle(
    fontSize: 14,
  );

  // Captions and Subtext
  static const TextStyle caption = TextStyle(
    fontSize: 14,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    color: AppColors.greyDark,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // Error and Status
  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    color: AppColors.error,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle statusSuccess = TextStyle(
    fontSize: 14,
    color: AppColors.success,
    fontWeight: FontWeight.bold,
  );

  // Links
  static const TextStyle link = TextStyle(
    fontSize: 16,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
  );

  // Dialog and Modal
  static const TextStyle dialogTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle dialogContent = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );
}
