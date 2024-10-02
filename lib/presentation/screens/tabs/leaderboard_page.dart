import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/spacing.dart';
import 'package:blindsplay/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/leaderboard/leaderboard_bloc.dart';
import '../../../logic/blocs/leaderboard/leaderboard_event.dart';
import '../../../logic/blocs/leaderboard/leaderboard_state.dart';
import '../../ui/sections/leaderboard.dart';
import '../../ui/sections/leaderboard_header.dart';
import '../../ui/sections/leaderboard_user_rank.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
          title: Text(
            'Leaderboard',
            style: AppTextStyles.heading3.copyWith(color: AppColors.accent),
          ),
          backgroundColor: AppColors.primary,
          scrolledUnderElevation: 0,
          foregroundColor: AppColors.onPrimary),
      body: BlocProvider(
        create: (context) =>
            LeaderboardBloc(apiUrl: 'https://your-api-url/leaderboard')
              ..add(StartLeaderboard()),
        child: const LeaderboardView(),
      ),
    );
  }
}

class LeaderboardView extends StatelessWidget {
  const LeaderboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardBloc, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeaderboardLoaded) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              children: [
                const LeaderboardHeader(),
                const SizedBox(height: AppSpacing.small),
                LeaderboardUserRank(entry: state.leaderboard[0]),
                const SizedBox(height: AppSpacing.large),
                Expanded(
                  child: Leaderboard(leaderboard: state.leaderboard),
                ),
              ],
            ),
          );
        } else if (state is LeaderboardError) {
          return Center(child: Text(state.message));
        } else {
          return Center(
            child: Text(
              'Reload leaderboard',
              style: AppTextStyles.heading3.copyWith(color: AppColors.accent),
            ),
          );
        }
      },
    );
  }
}
