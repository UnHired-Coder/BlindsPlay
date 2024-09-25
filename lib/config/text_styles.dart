import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart'; // Import your color definitions

class AppTextStyles {
  static const TextStyle textVeryLarge = TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  // Headings
  static const TextStyle heading1 = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle heading2 = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle heading3 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle bodyTextLarge = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  // Body Text
  static const TextStyle bodyText =
      TextStyle(fontSize: 16, fontFamily:  AppConstants.fontFamily1);

  static const TextStyle bodyTextSmall =
      TextStyle(fontSize: 14, fontFamily:  AppConstants.fontFamily1);

  // Captions and Subtext
  static const TextStyle caption =
      TextStyle(fontSize: 14, fontFamily:  AppConstants.fontFamily1);

  static const TextStyle overline = TextStyle(
      fontSize: 10, color: AppColors.greyDark, fontFamily:  AppConstants.fontFamily1);

  // Buttons
  static const TextStyle button = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle buttonSmall = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  // Error and Status
  static const TextStyle errorText = TextStyle(
      fontSize: 14,
      color: AppColors.error,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle statusSuccess = TextStyle(
      fontSize: 14,
      color: AppColors.success,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1);

  // Links
  static const TextStyle link = TextStyle(
      fontSize: 16,
      color: AppColors.accent,
      decoration: TextDecoration.underline,
      fontFamily:  AppConstants.fontFamily1);

  // Dialog and Modal
  static const TextStyle dialogTitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
      fontFamily:  AppConstants.fontFamily1);

  static const TextStyle dialogContent = TextStyle(
      fontSize: 16, color: Colors.black87, fontFamily:  AppConstants.fontFamily1);
}
