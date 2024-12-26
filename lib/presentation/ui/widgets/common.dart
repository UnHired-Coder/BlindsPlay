import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../config/constants.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/game/game_state.dart';
import '../../../network/repository/login/UserRepository.dart';
import '../../screens/auth/LoginPage.dart';
import '../../screens/game/GamePage.dart';
import 'AvatarAnimation.dart';
import 'base_cta_ui.dart';

Widget CompeteOnlineCta(BuildContext context,
    {String ctaText = "Compete online!"}) {
  return BaseCtaUi(
    context: context,
    text: ctaText,
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
  final UserRepository userRepository =
      Provider.of<UserRepository>(context, listen: false);
  if (userRepository.isLoggedIn) {
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
  } else {
    // User is not authenticated, navigate to login page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(), // Navigate to your login page
      ),
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

Widget MessageUi(String message, {Color color = AppColors.onPrimary}) {
  return Center(
    child: Text(
      message,
      style: TextStyle(
          fontSize: 20, color: color, fontFamily: AppConstants.fontFamily1),
    ),
  );
}

Widget PlayerCardUi({
  required String imageUrl,
  String? avatarUrl,
  required String? playerName,
  required String? rating,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      if (playerName == null)
        SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset('assets/searching_lottie.json'),
        ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.greyDark,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color with opacity
              spreadRadius: 2, // How much the shadow spreads
              blurRadius: 8, // The blur effect of the shadow
              offset: const Offset(0, 4), // Position of the shadow (x, y)
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: AppColors.greyDark,
                  borderRadius: BorderRadius.circular(5)),
            ),
            Container(
              width: 90,
              height: 90,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                      AppColors.primary,
                      AppColors.secondary,
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: GradientRotation(
                        30 * 3.14 / 180), // 30 degrees to radians
                  ),
                  borderRadius: BorderRadius.circular(3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    child: ((avatarUrl == null)
                        ? AvatarAnimation(
                            duration: const Duration(
                                milliseconds:
                                    300), // Change image every 0.5 seconds
                          )
                        : Image.network(avatarUrl)),
                  ),
                  if (playerName != null)
                    Text(
                      playerName,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 8,
                        fontFamily: AppConstants.fontFamily1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (rating != null)
                    Text(
                      rating,
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 10,
                        fontFamily: AppConstants.fontFamily1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}
