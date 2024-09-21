import 'package:blindsplay/config/screen_size.dart';
import 'package:flutter/cupertino.dart';

import '../../../config/colors.dart';
import '../../../config/text_styles.dart';

Widget GameRulesSection() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: ScreenSize.screenWidth / 2,
          child: Column(
            children: [
              Text(
                "Played classic tic-tac-toe?",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText
                    .copyWith(color: const Color(0xFF9F9898)),
                softWrap: true,
              ),
              const SizedBox(height: 20),
              Text(
                "Get ready for a new challenge!, after each move, the board hides the marks, showing only neutral indicators"
                    " instead of Xs and Os. Players must rely on memory to track their own and their opponent's moves.",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText
                    .copyWith(color: AppColors.accent),
                softWrap: true,
              ),
              const SizedBox(height: 20),
              Text(
                "Plan your strategy, remember your placements, and outsmart your opponent to win!",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText
                    .copyWith(color: const Color(0xFF9F9898)),
                softWrap: true,
              )
            ],
          )),
    ],
  );
}