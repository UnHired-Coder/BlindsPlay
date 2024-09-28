import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';

class LeaderboardHeader extends StatelessWidget {
  const LeaderboardHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        leading: Text(
          "RANK",
          style:
          AppTextStyles.bodyTextSmall.copyWith(color: AppColors.onPrimary),
        ),
        title: Row(
          children: [
            SizedBox(width: AppSpacing.large),
            Text(
              "NAME",
              style: AppTextStyles.bodyTextSmall
                  .copyWith(color: AppColors.onPrimary),
            ),
          ],
        ),
        trailing: Text(
          "RATING",
          style:
          AppTextStyles.bodyTextSmall.copyWith(color: AppColors.onPrimary),
        ),
      ),
    );
  }
}
