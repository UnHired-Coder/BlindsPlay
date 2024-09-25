import 'package:flutter/cupertino.dart';

import '../../../../config/colors.dart';
import '../../../../config/constants.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocks/game/game_state.dart';
import 'game_board.dart';

class ActiveGameBoard extends StatelessWidget {
  final GameInProgress state;
  final int boardSize; // Dynamic board size

  const ActiveGameBoard({required this.state, required this.boardSize});

  @override
  Widget build(BuildContext context) {
    final double boardWidth = boardSize * AppConstants.cellWidth;

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      // Duration of the animation
                      opacity: state.active ? 1 : 0.5,
                      child: Container(
                        width: boardWidth,
                        // Define a dynamic width for the board if needed
                        height: boardWidth,
                        // Define a dynamic width for the board if needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GameBoard(
                              visibleBoard: state.visibleBoard,
                              placeHolders: state.placeHolders,
                              active: state.active,
                            ),
                            !state.active
                                ? Text(
                                    "...",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.heading1
                                        .copyWith(color: AppColors.onPrimary),
                                  )
                                : Text("")
                          ],
                        ),
                      )),
                  Text(
                    "${state.currentPlayer.symbol}'s move...",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyTextLarge
                        .copyWith(color: AppColors.onPrimary),
                  )
                ],
              )
            ],
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: constraints.maxWidth > 1000
                    ? const EdgeInsets.all(100)
                    : EdgeInsets.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 24,
                      height: 24,
                      color: AppColors.onPrimary,
                      image: AssetImage(
                          'assets/ic_clock.png'), // Access icon from PageModel
                    ),
                    Text(
                      "${state.elapsedTime}s",
                      style: AppTextStyles.button
                          .copyWith(color: AppColors.onPrimary),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
          )),
        ],
      );
    });
  }
}
