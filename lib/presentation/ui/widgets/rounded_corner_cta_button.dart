import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class RoundedCornerButton extends StatelessWidget {
  final String text;
  final ImageProvider icon;
  final VoidCallback onPressed;

  const RoundedCornerButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onPrimary,
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min, // To match content width
        children: [
          Image(
            image: icon,
            width: 24,
            height: 24,
          ), // Leading icon
          SizedBox(width: 8), // Space between icon and text
          Text(
            text,
            style: TextStyle(
              fontSize: 16, // Text size
              fontWeight: FontWeight.w400,
              fontFamily: 'Itim', // Specify the font family if needed
            ),
          ),
        ],
      ),
    );
  }
}
