import 'package:flutter/cupertino.dart';
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
        child: ListView.separated(
          itemCount: recentGames.length * 20,
          itemBuilder: (context, index) {
            final entry = recentGames[index % 2];
            final color = entry.win ? AppColors.success : AppColors.error;
            return RecentGameTile(entry: entry, color: color);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.grey, // Color of the divider line
              thickness: 1.0, // Thickness of the line
            );
          },
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
      leading: const CircleAvatar(
        backgroundColor: AppColors.secondary,
        radius: 24,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.opponentName,
              style: AppTextStyles.bodyTextSmall
                  .copyWith(color: AppColors.onPrimary)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${entry.ratingBeforeGame}",
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: AppColors.grey)),
              const SizedBox(width: 6),
              Text("${entry.win ? "+" : ""}${entry.ratingChange}",
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
        child: Text(entry.win ? "W" : "L",
            style: AppTextStyles.bodyTextSmall.copyWith(color: color)),
      ),
    );
  }
}