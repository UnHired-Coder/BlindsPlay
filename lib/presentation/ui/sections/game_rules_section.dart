import 'package:flutter/cupertino.dart';

import '../../../config/colors.dart';
import '../../../config/text_styles.dart';

Widget GameRulesSection() {
  return LayoutBuilder(builder: (context, constraints) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: constraints.maxWidth / 2,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: "Plan your strategy, ",
                  style: AppTextStyles.heading3
                      .copyWith(color: const Color(0xFF9F9898)),
                  children: [
                    TextSpan(
                      text: "remember your placements",
                      style: AppTextStyles.heading3
                          .copyWith(color: AppColors.accent),
                    ),
                    TextSpan(
                      text: ", and outsmart your opponent to win!",
                      style: AppTextStyles.heading3
                          .copyWith(color: const Color(0xFF9F9898)),
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
