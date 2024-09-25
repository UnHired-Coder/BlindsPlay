import 'package:blindsplay/presentation/screens/pages.dart';
import 'package:flutter/material.dart';
import '../../../../config/colors.dart';
import '../../../../config/text_styles.dart';
import '../../../model/PageModel.dart';
import '../../../ui/sections/game_rules_section.dart';
import '../../../ui/sections/home_screen_banner.dart';
import '../../../ui/widgets/common.dart';

class MobileLayout extends StatelessWidget {
  final ValueChanged<int> onTabSelected; // To handle tab selection
  final int selectedIndex; // To manage the currently selected index
  final List<Widget> pageWidgets; // List of page widgets

  const MobileLayout({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
    required this.pageWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Aligns elements between top and bottom
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/ic_user.png",
                    width: 32,
                    height: 32,
                  ),
                )), // Aligns to the bottom
                const SizedBox(height: 20),
                HomeScreenBanner(),
                const SizedBox(height: 20),
                GameRulesSection(),
                const SizedBox(height: 60),
                CompeteOnlineCta(context),
                const SizedBox(height: 30),
                PlayNowCta(context),
              ],
            ),
            CustomAppBar(false), // Aligns to the bottom
          ],
        ),
      ),
    );
  }
}
