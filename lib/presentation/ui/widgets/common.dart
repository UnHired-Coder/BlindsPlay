import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/game/game_state.dart';
import '../../../util/firebase_auth.dart';
import '../../screens/auth/LoginPage.dart';
import '../../screens/game/game_page.dart';
import 'base_cta_ui.dart';

Widget CompeteOnlineCta(BuildContext context) {
  return BaseCtaUi(
    context: context,
    text: "Compete online!",
    icon: "assets/ic_lightning.png",
    onTap: () {
      launchGame(context, GameMode.onlineMultiplayer);
    },
  );
}

Widget PlayNowCta(BuildContext context) {
  return BaseCtaUi(
    context: context,
    text: "Play now!",
    icon: "assets/ic_play.png",
    onTap: () {
      launchGame(context, GameMode.offlineAgainstPC);
    },
  );
}

void launchGame(BuildContext context, GameMode gameMode) async {
  // Check if the user is authenticated
  final user = await AuthService()
      .getCurrentUser(); // Update this method to fetch the current user
  if (user == null) {
    // User is not authenticated, navigate to login page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigate to your login page
      ),
    );
  } else {
    // User is authenticated, proceed to the game page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GamePage(boardSize: 3, gameMode: gameMode);
        },
      ),
      (Route<dynamic> route) =>
          route.isFirst, // This will keep only the first route (main page).
    );
  }
}

AppBar CustomAppBar(isWeb) {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    title: Row(
      mainAxisAlignment:
          isWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/favicon.png",
          width: 57.4,
          height: 37.9,
        ),
        Text(
          'Tic Tac Memo',
          style: AppTextStyles.bodyText.copyWith(color: AppColors.onPrimary),
        )
      ],
    ),
    leading: null,
    centerTitle: !isWeb,
  );
}
