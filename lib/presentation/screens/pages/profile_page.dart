import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/colors.dart';
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
          /*IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(RefreshProfile());
            },
          ),*/
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
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${profile.name}',
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: AppColors.onPrimary),
                ),
                SizedBox(height: 8),
                Text(
                  'Rating: ${profile.rating}',
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: AppColors.onPrimary),
                ),
                SizedBox(height: 8),
                Text(
                  'Rank: ${profile.rank}',
                  style: AppTextStyles.bodyTextSmall
                      .copyWith(color: AppColors.onPrimary),
                ),
              ],
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
