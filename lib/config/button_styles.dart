import 'package:flutter/material.dart';
import 'colors.dart';
import 'constants.dart';

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary,
  foregroundColor: AppColors.onPrimary,
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);

final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.secondary,
  foregroundColor: AppColors.onPrimary,
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);

final ButtonStyle accentButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.accent,
  foregroundColor: AppColors.primary,
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);

final ButtonStyle textButtonStyle = TextButton.styleFrom(
  foregroundColor: AppColors.primary,
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily:  AppConstants.fontFamily1),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: AppColors.primary,
  side: const BorderSide(color: AppColors.primary, width: 2),
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);

final ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.secondary.withOpacity(0.5), // Disabled color
  foregroundColor: AppColors.onPrimary.withOpacity(0.5),
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);

final ButtonStyle hoverButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary.withOpacity(0.8), // Hover color
  foregroundColor: AppColors.onPrimary,
  textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily:  AppConstants.fontFamily1),
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
);
