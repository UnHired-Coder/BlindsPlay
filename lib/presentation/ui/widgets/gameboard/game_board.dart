import 'package:blindsplay/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/blocks/game/game_bloc.dart';
import '../../../../logic/blocks/game/game_event.dart';
import '../../../../logic/blocks/game/game_state.dart';
import 'game_bars.dart';
import 'game_tile.dart';

class GameBoard extends StatelessWidget {
  GameInProgress state;

  GameBoard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(AppConstants.boardSize, (row) {
            return _buildRow(context, row);
          }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(AppConstants.boardSize - 1, (index) {
            return const VerticalGameBar();
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(AppConstants.boardSize - 1, (index) {
            return const HorizontalGameBar();
          }),
        )
      ],
    );
  }

  Widget _buildRow(BuildContext context, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(AppConstants.boardSize, (columnIndex) {
        return GameTile(
            x: rowIndex,
            y: columnIndex,
            cellWidth: AppConstants.cellWidth,
            tileState: state.visibleBoard[rowIndex][columnIndex],
            placeHolder: state.placeHolders[rowIndex][columnIndex],
            onTap: () {
              if (state.active) {
                BlocProvider.of<GameBloc>(context)
                    .add(MakeMove(rowIndex, columnIndex));
              }
            });
      }),
    );
  }
}
