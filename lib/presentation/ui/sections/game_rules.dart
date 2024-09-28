import 'package:flutter/cupertino.dart';

import '../../../config/colors.dart';
import '../../../config/text_styles.dart';

Widget GameRulesSection() {
  return LayoutBuilder(builder: (context, constraints) {
    final fontStyle = constraints.maxWidth > 1000
        ? AppTextStyles.bodyTextLarge
        : AppTextStyles.bodyTextSmall;

    final isWeb = constraints.maxWidth > 1000;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width:
              isWeb ? (constraints.maxWidth / 2) : (constraints.maxWidth),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: "Plan your strategy, ",
                  style: fontStyle.copyWith(color: const Color(0xFF9F9898)),
                  children: [
                    TextSpan(
                      text: "remember your placements",
                      style: fontStyle.copyWith(color: AppColors.accent),
                    ),
                    TextSpan(
                      text: ", and\n outsmart your opponent to win!",
                      style: fontStyle.copyWith(color: const Color(0xFF9F9898)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  });
}
