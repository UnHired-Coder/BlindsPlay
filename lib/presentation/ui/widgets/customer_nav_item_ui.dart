import 'package:blindsplay/config/colors.dart';
import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class CustomNavItemUi extends StatelessWidget {
  final bool isSelected;
  final String label;
  final String imageUrl;
  final bool highlightedIndex;

  const CustomNavItemUi({
    super.key,
    required this.isSelected,
    required this.label,
    required this.imageUrl,
    required this.highlightedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
              Text(
                label,
                maxLines: 1,
                style: TextStyle(
                    color: (highlightedIndex
                        ? AppColors.success
                        : AppColors.surface),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily: AppConstants.fontFamily1),
              )
            ],
          ),
        ],
      ),
    );
  }
}
