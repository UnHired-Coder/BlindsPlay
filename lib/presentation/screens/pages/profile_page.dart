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
            icon: Icon(
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
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          final profile = state.profile;
          return Padding(
              padding: EdgeInsets.all(AppSpacing.large),
              child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(width: 0.5, color: AppColors.accent)),
                  child: ListTile(
                    leading: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NAME",
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.onPrimary)),
                        SizedBox(
                          height: AppSpacing.small,
                        ),
                        Text(profile.name,
                            style: AppTextStyles.bodyTextSmall
                                .copyWith(color: AppColors.onPrimary))
                      ],
                    ),
                    title: Row(
                      children: [
                        SizedBox(
                          width: AppSpacing.large,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("RATING",
                                style: AppTextStyles.caption
                                    .copyWith(color: AppColors.onPrimary)),
                            SizedBox(
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
                        SizedBox(
                          height: AppSpacing.small,
                        ),
                        Text('${profile.rank}',
                            style: AppTextStyles.bodyTextSmall
                                .copyWith(color: AppColors.onPrimary))
                      ],
                    ),
                  )));
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
