import 'package:blindsplay/config/constants.dart';
import 'package:blindsplay/presentation/ui/widgets/gameboard/game_board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/colors.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocks/game/game_state.dart';
import '../common.dart';

class FinishedGameBoard extends StatelessWidget {
  final GameOver state;

  const FinishedGameBoard({required this.state});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWeb = (constraints.maxWidth > 1000);
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppConstants.boardWidth * (isWeb ? 1 : 0.8),
                // Define a dynamic width for the board if needed
                height: AppConstants.boardWidth * (isWeb ? 1 : 0.8),
                child: GameBoard(
                  visibleBoard: state.finalBoard,
                  placeHolders: null,
                  active: true,
                  cellWidth: AppConstants.cellWidth * (isWeb ? 1 : 0.8),
                  boardSize: AppConstants.boardSize,
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
    });
  }
}
