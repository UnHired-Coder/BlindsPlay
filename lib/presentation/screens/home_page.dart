import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../ui/effects/game_rules_background_gradient.dart';
import '../ui/sections/game_rules_section.dart';
import '../ui/sections/home_screen_banner.dart';
import '../ui/widgets/rounded_corner_cta_button.dart';
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
                RoundedCornerButton(
                  text: "Compete online!",
                  icon: const AssetImage("assets/ic_lightning.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const GamePage(boardSize: 3) as Widget,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                RoundedCornerButton(
                  text: "Play now!",
                  icon: const AssetImage("assets/ic_play.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const GamePage(boardSize: 3) as Widget,
                      ),
                    );
                  },
                )
              ],
            )));
  }
}
