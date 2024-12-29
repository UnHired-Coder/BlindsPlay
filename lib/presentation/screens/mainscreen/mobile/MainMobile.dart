import 'package:blindsplay/network/repository/login/UserRepository.dart';
import 'package:blindsplay/presentation/screens/tabs/tabs.dart';
import 'package:flutter/material.dart';

import '../../../../config/colors.dart';
import '../../../ui/sections/home_screen_banner.dart';
import '../../../ui/widgets/common.dart';
import '../../auth/LoginPage.dart';

class MobileLayout extends StatelessWidget {
  final ValueChanged<int> onTabSelected; // To handle tab selection
  final int selectedIndex; // To manage the currently selected index
  final List<Widget> pageWidgets; // List of page widgets
  final UserRepository userRepository;
  const MobileLayout({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
    required this.pageWidgets,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Stack(
          // Use Stack for positioning elements freely
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 100),
                    HomeScreenBanner(),
                    // const SizedBox(height: 20),
                    // GameRulesSection(),
                    const SizedBox(height: 60),
                    CompeteOnlineCta(context),
                    const SizedBox(height: 30),
                    PlayNowCta(context),
                  ],
                ),
                CustomAppBar(false), // Aligns to the bottom
              ],
            ),
            Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  child: Image.asset(
                    "assets/ic_user.png",
                    width: 32,
                    height: 32,
                  ),
                  onTap: () {
                    _openLoginOrProfile(context);
                  },
                )), // Image aligned to top right with 10 padding
          ],
        ),
      ),
    );
  }

  _openLoginOrProfile(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => userRepository.isLoggedIn
            ? pageNavDestinations[2].page
            : LoginPage(),
      ),
    );
  }
}
