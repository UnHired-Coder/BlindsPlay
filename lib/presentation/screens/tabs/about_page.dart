import 'package:amplitude_flutter/amplitude.dart';
import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/text_styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage();

  @override
  Widget build(BuildContext context) {
    final amplitude = GetIt.instance<Amplitude>();
    amplitude.logEvent("Open AboutPage");

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
          title: Text('Help & Game Rules',
              style: AppTextStyles.heading3.copyWith(color: AppColors.accent)),
          backgroundColor: AppColors.primary,
          scrolledUnderElevation: 0,
          foregroundColor: AppColors.onPrimary),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.large),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Game Rules Section
              Text(
                'Game Rules',
                style:
                    AppTextStyles.heading1.copyWith(color: AppColors.onPrimary),
              ),
              SizedBox(height: 10),
              Text(
                '''1. The game is played on a 3x3 grid.
2. Players take turns placing their mark (X or O) in an empty square.
3. After each move, the entire grid is hidden, and players must rely on their memory to keep track of their moves and their opponent's moves.
4. The first player to get 3 of their marks in a row (horizontally, vertically, or diagonally) wins the game.
5. If all 9 squares are filled and neither player has 3 in a row, the game is a draw.
6. Multiplayer games match you with opponents of similar rating based on previous game performance.''',
                style: AppTextStyles.bodyTextSmall
                    .copyWith(color: AppColors.onPrimary),
              ),
              SizedBox(height: 30),
              // Contact Section
              Text(
                'Contact Us',
                style:
                    AppTextStyles.heading2.copyWith(color: AppColors.onPrimary),
              ),
              SizedBox(height: 10),
              Text(
                'For feedback or issues, please contact us at:',
                style: AppTextStyles.bodyTextSmall
                    .copyWith(color: AppColors.onPrimary),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // This can trigger an email action if needed
                },
                child: Text(
                  'tictacmemo.game@gmail.com',
                  style: AppTextStyles.link.copyWith(color: AppColors.accent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
