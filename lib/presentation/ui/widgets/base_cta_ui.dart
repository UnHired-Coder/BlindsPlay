import 'package:blindsplay/presentation/ui/widgets/rounded_corner_cta_button.dart';
import 'package:flutter/cupertino.dart';

Widget BaseCtaUi({
  String? icon = null,
  required BuildContext context,
  required String text, // Pass the icon path as a string
  required VoidCallback onTap,
}) {
  return RoundedCornerButton(
    text: text, // Use the passed text
    icon: icon != null ? AssetImage(icon) : null,
    // Convert the string to AssetImage
    onPressed: onTap, // Use the passed onTap function
  );
}
