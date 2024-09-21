import 'package:flutter/material.dart';

import '../../../../logic/blocks/game/game_state.dart';

class GameTile extends StatelessWidget {
  final int x, y;
  final double cellWidth;
  final TileState tileState;
  final VoidCallback onTap;

  const GameTile({
    super.key,
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
          color: tileState == TileState.red ? Colors.red : null,
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
