import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocks/profile/profile_bloc.dart';
import '../../../logic/blocks/profile/profile_event.dart';
import '../../../logic/blocks/profile/profile_state.dart';
import '../../ui/sections/profile_header_section.dart';
import '../../ui/sections/recent_games_section.dart';

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
        scrolledUnderElevation: 0,
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(apiUrl: 'https://api.example.com')
          ..add(LoadProfile()), // Trigger loading profile on creation
        child: const ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileHeader(profile: state.profile),
                const SizedBox(height: AppSpacing.large),
                ListTile(
                  leading: Text("RECENT GAMES",
                      style: AppTextStyles.bodyTextSmall
                          .copyWith(color: AppColors.onPrimary)),
                ),
                RecentGamesSection(recentGames: state.profile.recentGames)
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
