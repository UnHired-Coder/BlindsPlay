import 'package:blindsplay/config/colors.dart';
import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class CustomNavItemUi extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String imageUrl;

  const CustomNavItemUi({
    super.key,
    required this.isSelected,
    required this.label,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      color:
          isSelected ? AppColors.surface.withOpacity(0.1) : Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*Image(image: AssetImage(imageUrl)),
              SizedBox(width: 20),*/
              Text(
                label,
                maxLines: 1,
                style: TextStyle(
                    color: isSelected ? AppColors.accent : AppColors.surface,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily:  AppConstants.fontFamily1),
              )
            ],
          ),
        ],
      ),
    );
  }
}
