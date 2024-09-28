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
        scrolledUnderElevation: 0,
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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("RANK",
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary)),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: AppSpacing.large,
                                ),
                                Text("NAME",
                                    style: AppTextStyles.bodyTextSmall
                                        .copyWith(color: AppColors.onPrimary))
                              ],
                            ),
                            trailing: Text("RATING",
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSpacing.large,
                    ),
                    // Fixed Top Item
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border:
                              Border.all(width: 0.5, color: AppColors.accent)),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("${state.leaderboard[0].rank}",
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary)),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: AppSpacing.large,
                                ),
                                Text(state.leaderboard[0].name,
                                    style: AppTextStyles.bodyTextSmall
                                        .copyWith(color: AppColors.onPrimary))
                              ],
                            ),
                            trailing: Text('${state.leaderboard[0].rating}',
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary)),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable List Below
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView.builder(
                          itemCount: state.leaderboard.length,
                          itemBuilder: (context, index) {
                            final entry = state.leaderboard[index];
                            return ListTile(
                              leading: Text('${entry.rank}',
                                  style: AppTextStyles.bodyTextSmall
                                      .copyWith(color: AppColors.onPrimary)),
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: AppSpacing.large,
                                  ),
                                  Text(entry.name,
                                      style: AppTextStyles.bodyTextSmall
                                          .copyWith(color: AppColors.onPrimary))
                                ],
                              ),
                              trailing: Text('${entry.rating}',
                                  style: AppTextStyles.bodyTextSmall
                                      .copyWith(color: AppColors.onPrimary)),
                            );
                          },
                        ),
                      ),
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
              ));
            }
          },
        ),
      ),
    );
  }
}
