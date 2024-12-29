import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/profile/data/recent_game.dart';

class RecentGamesSection extends StatelessWidget {
  final List<RecentGame> recentGames;

  const RecentGamesSection({required this.recentGames});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: (recentGames.isNotEmpty)
            ? ListView.separated(
                itemCount: recentGames.length,
                itemBuilder: (context, index) {
                  final entry = recentGames[index];
                  final color = entry.ratingChange > 0 // win
                      ? AppColors.success
                      : (entry.ratingChange == 0) // draw
                          ? AppColors.grey
                          : AppColors.error;
                  return RecentGameTile(entry: entry, color: color);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey, // Color of the divider line
                    thickness: 1.0, // Thickness of the line
                  );
                },
              )
            : Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No recent games",
                    style: AppTextStyles.bodyTextSmall
                        .copyWith(color: AppColors.grey)),
              ),
      ),
    );
  }
}

class RecentGameTile extends StatelessWidget {
  final RecentGame entry;
  final Color color;

  const RecentGameTile({required this.entry, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
      leading: CircleAvatar(
        backgroundColor: AppColors.secondary,
        radius: 24,
        child: ClipOval(
          child: Transform.scale(
              scale: 1.5,
              child: Image.network(entry.opponentAvatar, fit: BoxFit.cover)),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.opponentUsername,
              style: AppTextStyles.bodyTextSmall
                  .copyWith(color: AppColors.onPrimary)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${entry.ratingBeforeChange}",
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: AppColors.grey)),
              const SizedBox(width: 6),
              Text("${entry.ratingChange >= 0 ? "+" : ""}${entry.ratingChange}",
                  style: AppTextStyles.bodyTextSmall.copyWith(color: color)),
            ],
          ),
        ],
      ),
      trailing: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
            entry.ratingChange > 0
                ? "W"
                : (entry.ratingChange == 0 ? "D" : "L"),
            style: AppTextStyles.bodyTextSmall.copyWith(color: color)),
      ),
    );
  }
}
