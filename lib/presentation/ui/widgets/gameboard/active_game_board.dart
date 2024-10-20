import 'package:flutter/cupertino.dart';

import '../../../../config/colors.dart';
import '../../../../config/constants.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocs/game/game_state.dart';
import 'game_board.dart';

class ActiveGameBoard extends StatelessWidget {
  final GameInProgress state;
  final int boardSize; // Dynamic board size
  final void Function(int row, int column)? onMakeMove;

  const ActiveGameBoard(
      {required this.state, required this.boardSize, required this.onMakeMove});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWeb = (constraints.maxWidth > 1000);

      final double boardWidth = (isWeb
          ? (boardSize * AppConstants.cellWidth)
          : constraints.maxWidth * 0.8);
      final double cellWidth = boardWidth / 3;

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
                              cellWidth: cellWidth,
                              boardSize: AppConstants.boardSize,
                              onMakeMove: onMakeMove,
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
                    : const EdgeInsets.all(20),
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
