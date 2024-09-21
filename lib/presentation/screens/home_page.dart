import 'package:blindsplay/presentation/ui/widgets/base_cta_ui.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../ui/effects/game_rules_background_gradient.dart';
import '../ui/sections/game_rules_section.dart';
import '../ui/sections/home_screen_banner.dart';
import 'game_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final Function(int, BuildContext) navigateToPage;

  const HomePage(
      {super.key, required this.pages, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  AppColors.primary.withOpacity(0.5),
                  AppColors.primary
                ],
                stops: const [0.3, 0.7, 1.0],
                center: Alignment.center,
                radius: 1,
                // Applying GradientTransform to create an elliptical gradient
                transform: const CenteredEllipticalGradientTransform(
                    scaleX: 1.2,
                    scaleY: 0.4), // Stretch horizontally and shrink vertically
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeScreenBanner(),
                const SizedBox(height: 16),
                GameRulesSection(),
                const SizedBox(height: 60),
                CompeteOnlineCta(context),
                const SizedBox(height: 30),
                PlayNowCta(context)
              ],
            )));
  }

  Widget CompeteOnlineCta(context) {
    return BaseCtaUi(
        context: context,
        text: "Compete online!",
        icon: "assets/ic_lightning.png",
        onTap: () {
          launchGame(context);
        });
  }

  Widget PlayNowCta(context) {
    return BaseCtaUi(
        context: context,
        text: "Play now!",
        icon: "assets/ic_play.png",
        onTap: () {
          launchGame(context);
        });
  }

  void launchGame(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GamePage(boardSize: 3) as Widget,
      ),
    );
  }
}
