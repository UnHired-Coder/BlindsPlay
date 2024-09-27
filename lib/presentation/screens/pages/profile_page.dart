import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocks/profile/profile_bloc.dart';
import '../../../logic/blocks/profile/profile_event.dart';
import '../../../logic/blocks/profile/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text('Profile',
            style: AppTextStyles.heading3.copyWith(color: AppColors.accent)),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: AppColors.onPrimary,
            ),
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(RefreshProfile());
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(apiUrl: 'https://api.example.com')
          ..add(LoadProfile()), // Trigger loading profile on creation
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;
          return Padding(
              padding: const EdgeInsets.all(AppSpacing.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border:
                              Border.all(width: 0.5, color: AppColors.accent)),
                      child: ListTile(
                        leading: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NAME",
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.onPrimary)),
                            const SizedBox(
                              height: AppSpacing.small,
                            ),
                            Text(profile.name,
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary))
                          ],
                        ),
                        title: Row(
                          children: [
                            const SizedBox(
                              width: AppSpacing.large,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("RATING",
                                    style: AppTextStyles.caption
                                        .copyWith(color: AppColors.onPrimary)),
                                const SizedBox(
                                  height: AppSpacing.small,
                                ),
                                Text('${profile.rating}',
                                    style: AppTextStyles.bodyTextSmall
                                        .copyWith(color: AppColors.onPrimary)),
                              ],
                            )
                          ],
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("RANK",
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.onPrimary)),
                            const SizedBox(
                              height: AppSpacing.small,
                            ),
                            Text('${profile.rank}',
                                style: AppTextStyles.bodyTextSmall
                                    .copyWith(color: AppColors.onPrimary))
                          ],
                        ),
                      )),
                  const SizedBox(height: AppSpacing.large),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text("RECENT GAMES",
                              style: AppTextStyles.bodyTextSmall
                                  .copyWith(color: AppColors.onPrimary)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.separated(
                        itemCount: state.profile.recentGames.length,
                        itemBuilder: (context, index) {
                          final entry = state.profile.recentGames[index];

                          final colour =
                              entry.win ? AppColors.success : AppColors.error;

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.small),
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.secondary,
                              // Circular background color
                              radius: 24,
                              // Size of the circle
                              child: Icon(
                                Icons.person, // Icon inside the circle
                                color: Colors.white,
                              ),
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
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                        "${entry.win ? "+" : ""}${entry.ratingChange}",
                                        style: AppTextStyles.bodyTextSmall
                                            .copyWith(color: colour))
                                  ],
                                )
                              ],
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: colour.withOpacity(0.3),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6))),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Text(entry.win ? "W" : "L",
                                  style: AppTextStyles.bodyTextSmall
                                      .copyWith(color: colour)),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.grey, // Color of the divider line
                            thickness: 1.0, // Thickness of the line
                          );
                        },
                      ),
                    ),
                  )
                ],
              ));
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
