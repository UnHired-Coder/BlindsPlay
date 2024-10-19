import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/colors.dart';
import '../../model/PageModel.dart';
import '../../ui/effects/game_rules_background_gradient.dart';
import '../../ui/sections/game_rules.dart';
import '../../ui/sections/home_screen_banner.dart';
import '../../ui/widgets/common.dart';

class HomePage extends StatelessWidget {
  final List<PageNavModel> pages; // Change to List<PageModel>
  final Function(int, BuildContext) navigateToPage;

  const HomePage({
    super.key,
    required this.pages,
    required this.navigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    final amplitude = GetIt.I<Amplitude>();
    amplitude.logEvent("Open HomePage");

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              AppColors.primary.withOpacity(0.3),
              AppColors.primary
            ],
            stops: const [0.3, 0.7, 1.0],
            center: Alignment.center,
            radius: 1,
            transform: const CenteredEllipticalGradientTransform(
              scaleX: 1.2,
              scaleY: 0.4,
            ), // Stretch horizontally and shrink vertically
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
            PlayNowCta(context),
          ],
        ),
      ),
    );
  }
}
