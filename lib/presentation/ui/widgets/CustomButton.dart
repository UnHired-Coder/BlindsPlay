import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameModeWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const GameModeWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.secondary, // Background color similar to the original
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyTextSmall.copyWith(
                    color: AppColors.onPrimary, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: AppTextStyles.bodyTextSmall
                    .copyWith(color: AppColors.surface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
