import 'package:blindsplay/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) =>
            GameBloc()..add(StartGame()), // Start game when the page is created
        child: _GameContent(boardSize: boardSize),
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
  final int boardSize; // Dynamic board size

  const _GameBoard({required this.state, required this.boardSize});

  @override
  Widget build(BuildContext context) {
    const double cellWidth = 100;
    final double boardWidth = boardSize * cellWidth;
    const double barWidth = 10;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: boardWidth,
              // Define a dynamic width for the board if needed
              height: boardWidth,
              // Define a dynamic width for the board if needed
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(boardSize, (row) {
                      return _buildRow(context, row, cellWidth);
                    }),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(boardSize - 1, (index) {
                      return Container(
                          width: boardWidth,
                          height: barWidth,
                          color: AppColors.accent);
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(boardSize - 1, (index) {
                      return Container(
                          width: barWidth,
                          height: boardWidth,
                          color: AppColors.accent);
                    }),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  // Build each row
  Widget _buildRow(BuildContext context, int rowIndex, double cellWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(boardSize, (columnIndex) {
        return _GameTile(
            x: rowIndex,
            y: columnIndex,
            cellWidth: cellWidth,
            tileState: state.visibleBoard[rowIndex][columnIndex],
            onTap: () {
              BlocProvider.of<GameBloc>(context)
                  .add(MakeMove(rowIndex, columnIndex));
            });
      }),
    );
  }
}

class _GameTile extends StatelessWidget {
  final int x, y;
  final double cellWidth;
  final TileState tileState;
  final VoidCallback onTap;

  const _GameTile({
    required this.x,
    required this.y,
    required this.cellWidth,
    required this.tileState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cellWidth, // Adjust tile width based on board size if needed
        height: cellWidth, // Adjust tile height based on board size if needed
        decoration: BoxDecoration(
          color: tileState == TileState.red ? Colors.red : AppColors.primary,
          //border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Text(
            tileState == TileState.red ? "" : tileState.symbol,
            // Hide the symbol if the box is red
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
