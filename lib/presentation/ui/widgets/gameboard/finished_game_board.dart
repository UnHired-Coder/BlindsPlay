import 'package:blindsplay/config/constants.dart';
import 'package:blindsplay/logic/blocks/game/game_event.dart';
import 'package:blindsplay/presentation/ui/widgets/gameboard/game_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/colors.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocks/game/game_bloc.dart';
import '../../../../logic/blocks/game/game_state.dart';
import '../../sections/home_screen_banner.dart';
import '../base_cta_ui.dart';

class FinishedGameBoard extends StatelessWidget {
  final GameOver state;

  const FinishedGameBoard({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppConstants.boardWidth,
              // Define a dynamic width for the board if needed
              height: AppConstants.boardWidth,
              child: GameBoard(
                  visibleBoard: state.finalBoard,
                  placeHolders: null,
                  active: true),
            ),
            const SizedBox(height: 24),
            Text(
              state.result,
              textAlign: TextAlign.center,
              style: AppTextStyles.textVeryLarge
                  .copyWith(color: AppColors.onPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              "(Finished in: ${state.elapsedTime}s)",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(color: AppColors.accent),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CompeteOnlineCta(context),
                const SizedBox(width: 40),
                PlayNowCta(context),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget CompeteOnlineCta(context) {
    return BaseCtaUi(
        context: context,
        text: "Compete online!",
        icon: "assets/ic_lightning.png",
        onTap: () {
          launchGame(context, GameMode.onlineMultiplayer);
        });
  }

  Widget PlayNowCta(context) {
    return BaseCtaUi(
        context: context,
        text: "Play now!",
        icon: "assets/ic_play.png",
        onTap: () {
          launchGame(context, GameMode.offline2Players);
        });
  }

  void launchGame(context, GameMode gameMode) {
    BlocProvider.of<GameBloc>(context).add(StartGame(gameMode));
  }
}
