import 'package:flutter/material.dart';

import '../../../../logic/blocs/game/game_state.dart';
import 'game_bars.dart';
import 'game_tile.dart';

class GameBoard extends StatelessWidget {
  final List<List<TileState>> visibleBoard;
  final List<List<String>>? placeHolders;
  final bool active;
  final double cellWidth;
  final int boardSize;
  final void Function(int row, int column)? onMakeMove;

  GameBoard(
      {super.key,
      required this.visibleBoard,
      required this.placeHolders,
      required this.active,
      required this.cellWidth,
      required this.boardSize,
      required this.onMakeMove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(boardSize, (row) {
            return _buildRow(context, row);
          }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(boardSize - 1, (index) {
            return VerticalGameBar(
              barThickness: cellWidth * 0.15,
            );
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(boardSize - 1, (index) {
            return HorizontalGameBar(
              barThickness: cellWidth * 0.15,
            );
          }),
        )
      ],
    );
  }

  Widget _buildRow(BuildContext context, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(boardSize, (columnIndex) {
        return GameTile(
          x: rowIndex,
          y: columnIndex,
          cellWidth: cellWidth,
          tileState: visibleBoard[rowIndex][columnIndex],
          placeHolder: placeHolders?[rowIndex][columnIndex],
          onTap: () {
            if (active) {
              onMakeMove?.call(rowIndex, columnIndex);
            }
          },
        );
      }),
    );
  }
}
