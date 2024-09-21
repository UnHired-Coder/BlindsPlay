import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/constants.dart';
import 'package:blindsplay/presentation/ui/widgets/gameboard/game_board.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/text_styles.dart';
import '../../logic/blocks/game/game_bloc.dart';
import '../../logic/blocks/game/game_event.dart';
import '../../logic/blocks/game/game_state.dart';

class GamePage extends StatelessWidget {
  final int boardSize; // Dynamic board size

  const GamePage({Key? key, required this.boardSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: !kIsWeb ? _buildAppBar() : null,
      body: BlocProvider(
        create: (context) =>
            GameBloc()..add(StartGame()), // Start game when the page is created
        child: _GameContent(boardSize: boardSize),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.onPrimary),
      backgroundColor: AppColors.primary,
      title: const SizedBox.shrink(),
    );
  }
}

class _GameContent extends StatelessWidget {
  final int boardSize;

  const _GameContent({required this.boardSize});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInitial) {
          return _buildMessage('Start a new game!');
        } else if (state is GameInProgress) {
          return _GameBoard(state: state, boardSize: boardSize);
        } else if (state is  GameOver) {
          return _buildMessage('Game Over: ${state.result}');
        } else if (state is GameError) {
          return _buildMessage('Error: ${state.error}');
        } else {
          return _buildMessage('Unknown State');
        }
      },
    );
  }

  Widget _buildMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

class _GameBoard extends StatelessWidget {
  final GameInProgress state;
  final int boardSize; // Dynamic board size

  const _GameBoard({required this.state, required this.boardSize});

  @override
  Widget build(BuildContext context) {
    final double boardWidth = boardSize * AppConstants.cellWidth;

    return Row(
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
                      GameBoard(state: state),
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
    );
  }
}
