import 'package:blindsplay/config/constants.dart';
import 'package:blindsplay/presentation/ui/widgets/gameboard/game_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/colors.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocs/game/game_state.dart';
import '../common.dart';

class FinishedGameBoard extends StatelessWidget {
  final GameOver state;
  final int boardSize; // Dynamic board size

  const FinishedGameBoard({required this.state, required this.boardSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWeb = (constraints.maxWidth > 1000);

      final double boardWidth =
          (isWeb ? AppConstants.boardWidth : (AppConstants.boardWidth));
      final double cellWidth = boardWidth / 3;

      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: boardWidth,
                height: boardWidth,
                child: GameBoard(
                  visibleBoard: state.finalBoard,
                  placeHolders: null,
                  active: true,
                  cellWidth: cellWidth,
                  boardSize: AppConstants.boardSize,
                  onMakeMove: (_, __) {},
                ),
              ),
              const SizedBox(height: 24),
              Text(
                state.result,
                textAlign: TextAlign.center,
                softWrap: true,
                style: (isWeb
                        ? AppTextStyles.textVeryLarge
                        : AppTextStyles.heading1)
                    .copyWith(color: AppColors.onPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                "(Finished in: ${state.elapsedTime}s)",
                softWrap: true,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText.copyWith(color: AppColors.accent),
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CompeteOnlineCta(context, ctaText: "Play again!"),
                  // SizedBox(height: isWeb ? 40 : 20),
                  // PlayNowCta(context),
                ],
              )
            ],
          )
        ],
      );
    });
  }
}
