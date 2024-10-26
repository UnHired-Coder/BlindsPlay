import 'package:amplitude_flutter/amplitude.dart';
import 'package:blindsplay/presentation/screens/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/profile/profile_bloc.dart';
import '../../../logic/blocs/profile/profile_event.dart';
import '../../../logic/blocs/profile/profile_state.dart';
import '../../../network/repository/login/UserRepository.dart';
import '../../model/PageModel.dart';
import '../../ui/sections/profile_header.dart';
import '../../ui/sections/recent_games.dart';
import '../../ui/widgets/base_cta_ui.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    final amplitude = GetIt.I<Amplitude>();
    amplitude.logEvent("Open ProfilePage");

    final userRepository = GetIt.I<UserRepository>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
          title: Text('Profile',
              style: AppTextStyles.heading3.copyWith(color: AppColors.accent)),
          backgroundColor: AppColors.primary,
          scrolledUnderElevation: 0,
          foregroundColor: AppColors.onPrimary),
      body: BlocProvider(
        create: (context) => ProfileBloc(apiUrl: 'https://api.example.com')
          ..add(LoadProfile()), // Trigger loading profile on creation
        child: userRepository.isLoggedIn
            ? const ProfileView()
            : const ProfileView(),
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
          return LayoutBuilder(builder: (context, constraints) {
            final isWeb = (constraints.maxWidth > 1000);

            return Padding(
              padding: const EdgeInsets.all(AppSpacing.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileHeader(profile: state.profile),
                  const SizedBox(height: AppSpacing.large),
                  if (!isWeb) MobileNavigationButtons(context),
                  ListTile(
                    leading: Text("RECENT GAMES",
                        style: AppTextStyles.bodyTextSmall
                            .copyWith(color: AppColors.onPrimary)),
                  ),
                  RecentGamesSection(recentGames: state.profile.recentGames)
                ],
              ),
            );
          });
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }

  Widget MobileNavigationButtons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        NavigateToPageCta(context, pageNavDestinations[1]),
        SizedBox(
          width: AppSpacing.small,
        ),
        NavigateToPageCta(context, pageNavDestinations[3]),
      ],
    );
  }

  Widget NavigateToPageCta(context, PageNavModel pageNavDestinations) {
    return BaseCtaUi(
        context: context,
        text: pageNavDestinations.title,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pageNavDestinations.page,
            ),
          );
        });
  }
}
