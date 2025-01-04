import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../config/colors.dart';
import '../../../../config/constants.dart';
import '../../../../config/text_styles.dart';
import '../../../../logic/blocs/game/game_state.dart';
import 'game_board.dart';

class ActiveGameBoard extends StatefulWidget {
  final GameInProgress state;
  final int boardSize; // Dynamic board size
  final void Function(int row, int column)? onMakeMove;

  const ActiveGameBoard(
      {required this.state, required this.boardSize, required this.onMakeMove});

  @override
  State<ActiveGameBoard> createState() => _ActiveGameBoardState();
}

class _ActiveGameBoardState extends State<ActiveGameBoard> {
  double _rotationAngle = 0.0; // Initial rotation angle
  double _timerProgress = 1.0; // Timer progress from 1.0 to 0.0
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const totalDuration = 8; // Duration in seconds
    _timerProgress = 1.0;

    _timer?.cancel(); // Cancel existing timer if any
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _timerProgress -= 0.1 / totalDuration; // Decrease progress
        if (_timerProgress <= 0) {
          _timerProgress = 1.0; // Reset timer progress
          _rotationAngle += 90.0; // Rotate the board by 90 degrees
          //if (_rotationAngle >= 360) _rotationAngle = 0.0; // Reset rotation
          timer.cancel();
          _startTimer(); // Restart the timer
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWeb = (constraints.maxWidth > 1000);

      final double boardWidth =
          (isWeb ? AppConstants.boardWidth : (AppConstants.boardWidth));
      final double cellWidth = boardWidth / AppConstants.boardSize;

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
                  AnimatedRotation(
                      turns: _rotationAngle / 360,
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          // Duration of the animation
                          opacity: widget.state.active ? 1 : 0.5,
                          child: Container(
                            width: boardWidth,
                            // Define a dynamic width for the board if needed
                            height: boardWidth,
                            // Define a dynamic width for the board if needed
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                GameBoard(
                                  visibleBoard: widget.state.visibleBoard,
                                  placeHolders: widget.state.placeHolders,
                                  active: widget.state.active,
                                  cellWidth: cellWidth,
                                  boardSize: AppConstants.boardSize,
                                  onMakeMove: widget.onMakeMove,
                                ),
                                !widget.state.active
                                    ? Text(
                                        "...",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.heading1.copyWith(
                                            color: AppColors.onPrimary),
                                      )
                                    : Text("")
                              ],
                            ),
                          ))),
                  Text(
                    "${widget.state.currentPlayer.symbol}'s move...",
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
                    const Image(
                      width: 24,
                      height: 24,
                      color: AppColors.onPrimary,
                      image: AssetImage(
                          'assets/ic_clock.png'), // Access icon from PageModel
                    ),
                    Text(
                      "${widget.state.elapsedTime}s",
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
