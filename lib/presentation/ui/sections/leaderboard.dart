import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/leaderboard/data/leader_board_entry.dart';

class Leaderboard extends StatelessWidget {
  final List<LeaderboardEntry> leaderboard;

  const Leaderboard({required this.leaderboard});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaderboard.length, // Already showed the top entry
      itemBuilder: (context, index) {
        final entry = leaderboard[index]; // Start from the second entry
        return LeaderboardItem(entry: entry);
      },
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
