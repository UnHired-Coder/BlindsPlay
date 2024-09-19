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
        create: (context) => GameBloc()..add(StartGame()), // Start game when the page is created
        child: _GameContent(),
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
}

class _GameContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameInitial) {
          return _buildMessage('Start a new game!');
        } else if (state is GameInProgress) {
          return _GameBoard(state: state);
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
}

class _GameBoard extends StatelessWidget {
  final GameInProgress state;

  const _GameBoard({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 300, // Fixed width for the board
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final x = index % 3;
            final y = index ~/ 3;
            final visibleBoard = state.visibleBoard;

            return _GameTile(
              x: x,
              y: y,
              tileState: visibleBoard[x][y],
              onTap: () {
                BlocProvider.of<GameBloc>(context).add(MakeMove(x, y));
              },
            );
          },
        ),
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final int x, y;
  final TileState tileState;
  final VoidCallback onTap;

  const _GameTile({
    required this.x,
    required this.y,
    required this.tileState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: tileState == TileState.red ? Colors.red : AppColors.onPrimary,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            tileState == TileState.red ? "" : tileState.symbol, // Hide the symbol if the box is red
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
