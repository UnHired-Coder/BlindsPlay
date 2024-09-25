import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocks/game/game_state.dart';
import '../../screens/game/game_page.dart';
import 'base_cta_ui.dart';

Widget CompeteOnlineCta(BuildContext context) {
  return BaseCtaUi(
    context: context,
    text: "Compete online!",
    icon: "assets/ic_lightning.png",
    onTap: () {
      launchGame(context, GameMode.offlineAgainstPC);
    },
  );
}

Widget PlayNowCta(BuildContext context) {
  return BaseCtaUi(
    context: context,
    text: "Play now!",
    icon: "assets/ic_play.png",
    onTap: () {
      launchGame(context, GameMode.offline2Players);
    },
  );
}

void launchGame(BuildContext context, GameMode gameMode) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GamePage(boardSize: 3, gameMode: gameMode),
    ),
  );
}

AppBar CustomAppBar(isWeb) {
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.primary,
    title: Row(
      mainAxisAlignment: isWeb? MainAxisAlignment.start : MainAxisAlignment.center,
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