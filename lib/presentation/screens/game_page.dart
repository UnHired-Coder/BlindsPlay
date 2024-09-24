import 'package:blindsplay/config/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/blocks/game/game_bloc.dart';
import '../../logic/blocks/game/game_event.dart';
import '../../logic/blocks/game/game_state.dart';
import '../ui/effects/fade_in_widget.dart';
import '../ui/widgets/gameboard/active_game_board.dart';
import '../ui/widgets/gameboard/finished_game_board.dart';

class GamePage extends StatelessWidget {
  final int boardSize; // Dynamic board size
  final GameMode gameMode;

  const GamePage({Key? key, required this.boardSize, required this.gameMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: !kIsWeb ? _buildAppBar() : null,
      body: BlocProvider(
        create: (context) =>
            GameBloc(gameMode: gameMode)..add(StartGame(gameMode)), // Start game when the page is created
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
          return FadeInWidget(key: Key("GameStart"), child:  _buildMessage('Get ready...'));
        } else if (state is GameWaiting) {
          return FadeInWidget(key: Key("GameStart"), child:  _buildMessage('Game starts in : ${state.countdown}s'));
        } else if (state is GameInProgress) {
          return FadeInWidget(key: Key("ActiveGameBoard"),child: ActiveGameBoard(state: state, boardSize: boardSize));
        } else if (state is GameOver) {
          return FadeInWidget(key: Key("FinishedGameBoard"), child: FinishedGameBoard(state: state));
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
        style: const TextStyle(fontSize: 24, color: AppColors.onPrimary),
      ),
    );
  }
}
