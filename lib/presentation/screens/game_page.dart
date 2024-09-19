import 'package:blindsplay/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocks/game/game_bloc.dart';
import '../../logic/blocks/game/game_event.dart';
import '../../logic/blocks/game/game_state.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => GameBloc()..add(StartGame()), // Fire StartGame event when the screen loads
        child: _buildGameContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.onPrimary),
      backgroundColor: AppColors.primary,
      title: const SizedBox.shrink(),
    );
  }

  Widget _buildGameContent() {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInitial) {
          return _buildMessage('Start a new game!');
        } else if (state is GameInProgress) {
          return _buildGameBoard(context, state);
        } else if (state is GameOver) {
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

  Widget _buildGameBoard(BuildContext context, GameInProgress state) {
    // Example: a simple 3x3 grid where users can tap to make a move
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        final x = index % 3;
        final y = index ~/ 3;
        final board = state.board; // Access the current board state

        return GestureDetector(
          onTap: () {
            // Fire MakeMove event when a tile is tapped
            BlocProvider.of<GameBloc>(context).add(MakeMove(x, y));
          },
          child: Container(
            color: AppColors.onPrimary,
            child: Center(
              child: Text(
                board[x][y], // Display X or O based on the current state of the board
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
