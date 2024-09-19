import 'package:blindsplay/config/colors.dart';
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
    const double cellWidth = 150;
    final double boardWidth = boardSize * cellWidth;
    const double barWidth = 15;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff7e664c), Color(0xfff4b059)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(
                                5), // Set the circular radius here
                          ));
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(boardSize - 1, (index) {
                      return Container(
                          width: barWidth,
                          height: boardWidth,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff7e664c), Color(0xfff4b059)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                5), // Set the circular radius here
                          ));
                    }),
                  ),
                ],
              ),
            ),
            Text(
              "finding your opponent...",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyTextLarge
                  .copyWith(color: AppColors.onPrimary),
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
        ),
        child: Center(
          child:
              _buildTileContent(tileState), // Use custom UI based on tileState
        ),
      ),
    );
  }

  // Custom UI for each TileState
  Widget _buildTileContent(TileState tileState) {
    switch (tileState) {
      case TileState.X:
        return _buildCustomXUI(); // Custom UI for X
      case TileState.O:
        return _buildCustomOUI(); // Custom UI for O
      case TileState.red:
        return _buildRedBoxUI(); // Custom UI for red state
      case TileState.empty:
      default:
        return _buildEmptyUI(); // Custom UI for empty state
    }
  }

  // Custom UI for X state
  Widget _buildCustomXUI() {
    return Icon(Icons.close,
        size: 60, color: Color(0xffFF2A2A)); // Example: X icon
  }

  // Custom UI for O state
  Widget _buildCustomOUI() {
    return Icon(Icons.radio_button_unchecked,
        size: 60, color: Color(0xff8EFE82)); // Example: O icon
  }

  // Custom UI for red state (this could be a red background or different layout)
  Widget _buildRedBoxUI() {
    return Container(
      width: 40,
      height: 40,
      color: Colors.redAccent, // This can be any custom design you want
    );
  }

  // Custom UI for empty state
  Widget _buildEmptyUI() {
    return Container(); // Empty container or any placeholder UI for an empty state
  }
}
