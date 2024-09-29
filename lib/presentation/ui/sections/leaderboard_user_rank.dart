import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/leaderboard/data/leader_board_entry.dart';

class LeaderboardUserRank extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardUserRank({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(width: 0.5, color: AppColors.accent),
      ),
      child: ListTile(
        leading: Text(
          '${entry.rank}',
          style:
          AppTextStyles.bodyTextSmall.copyWith(color: AppColors.onPrimary),
        ),
        title: Row(
          children: [
            const SizedBox(width: AppSpacing.large),
            Text(
              entry.name,
              style: AppTextStyles.bodyTextSmall
                  .copyWith(color: AppColors.onPrimary),
            ),
          ],
        ),
        trailing: Text(
          '${entry.rating}',
          style:
          AppTextStyles.bodyTextSmall.copyWith(color: AppColors.onPrimary),
        ),
      ),
    );
  }
}
