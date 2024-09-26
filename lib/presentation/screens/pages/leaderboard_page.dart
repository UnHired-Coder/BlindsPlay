import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/spacing.dart';
import 'package:blindsplay/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocks/leaderboard/leaderboard_bloc.dart';
import '../../../logic/blocks/leaderboard/leaderboard_event.dart';
import '../../../logic/blocks/leaderboard/leaderboard_state.dart';

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
      ),
      body: BlocProvider(
        create: (context) =>
            LeaderboardBloc(apiUrl: 'https://your-api-url/leaderboard')
              ..add(StartLeaderboard()),
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          builder: (context, state) {
            if (state is LeaderboardLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LeaderboardLoaded) {
              return Padding(
                padding: EdgeInsets.all(AppSpacing.large),
                child: ListView.builder(
                  itemCount: state.leaderboard.length,
                  itemBuilder: (context, index) {
                    final entry = state.leaderboard[index];
                    return ListTile(
                      leading: Text('${entry.rank}',
                          style: AppTextStyles.bodyTextSmall
                              .copyWith(color: AppColors.onPrimary)),
                      title: Text(entry.name,
                          style: AppTextStyles.bodyTextSmall
                              .copyWith(color: AppColors.onPrimary)),
                      trailing: Text('${entry.rating}',
                          style: AppTextStyles.bodyTextSmall
                              .copyWith(color: AppColors.onPrimary)),
                    );
                  },
                ),
              );
            } else if (state is LeaderboardError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Press to load leaderboard'));
            }
          },
        ),
      ),
    );
  }
}
