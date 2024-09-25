import 'dart:math';

import '../game/game_state.dart';

class TicTacToeHelper {
  final int boardSize = 3;

  Point<int>? getSmartMove(List<List<TileState>> board, TileState currentPlayer) {
    TileState opponent = currentPlayer == TileState.X ? TileState.O : TileState.X;

    // 1. Check if the current player can win
    var winMove = _findWinningMove(board, currentPlayer);
    if (winMove != null && _isValidMove(board, winMove)) return winMove;

    // 2. Block opponent's winning move
    var blockMove = _findWinningMove(board, opponent);
    if (blockMove != null && _isValidMove(board, blockMove)) return blockMove;

    // 3. Create a fork
    var forkMove = _findFork(board, currentPlayer);
    if (forkMove != null && _isValidMove(board, forkMove)) return forkMove;

    // 4. Block opponent's fork
    var blockForkMove = _findFork(board, opponent);
    if (blockForkMove != null && _isValidMove(board, blockForkMove)) return blockForkMove;

    // 5. Take the center
    if (board[1][1] == TileState.empty) return Point(1, 1);

    // 6. Take the opposite corner if opponent is in a corner
    var oppositeCorner = _takeOppositeCorner(board, opponent);
    if (oppositeCorner != null && _isValidMove(board, oppositeCorner)) return oppositeCorner;

    // 7. Take any empty corner
    var emptyCorner = _findEmptyCorner(board);
    if (emptyCorner != null && _isValidMove(board, emptyCorner)) return emptyCorner;

    // 8. Take any empty side
    return _findEmptySide(board);
  }

  Point<int>? _findWinningMove(List<List<TileState>> board, TileState player) {
    for (int i = 0; i < boardSize; i++) {
      // Check rows
      if (_canWin(board[i][0], board[i][1], board[i][2], player)) {
        return Point(i, _findEmptyIndex(board[i]));
      }
      // Check columns
      if (_canWin(board[0][i], board[1][i], board[2][i], player)) {
        return Point(_findEmptyIndex([board[0][i], board[1][i], board[2][i]]), i);
      }
    }
    // Check diagonals
    if (_canWin(board[0][0], board[1][1], board[2][2], player)) {
      return Point(_findEmptyIndex([board[0][0], board[1][1], board[2][2]]),
          _findEmptyIndex([board[0][0], board[1][1], board[2][2]]));
    }
    if (_canWin(board[0][2], board[1][1], board[2][0], player)) {
      return Point(_findEmptyIndex([board[0][2], board[1][1], board[2][0]]),
          _findEmptyIndex([board[0][2], board[1][1], board[2][0]]));
    }
    return null;
  }

  bool _canWin(TileState a, TileState b, TileState c, TileState player) {
    return (a == player && b == player && c == TileState.empty) ||
        (a == player && b == TileState.empty && c == player) ||
        (a == TileState.empty && b == player && c == player);
  }

  int _findEmptyIndex(List<TileState> line) {
    return line.indexOf(TileState.empty);
  }

  Point<int>? _findFork(List<List<TileState>> board, TileState player) {
    // Add logic to detect forks
    return null;
  }

  Point<int>? _takeOppositeCorner(List<List<TileState>> board, TileState opponent) {
    if (board[0][0] == opponent && board[2][2] == TileState.empty) return Point(2, 2);
    if (board[2][2] == opponent && board[0][0] == TileState.empty) return Point(0, 0);
    if (board[0][2] == opponent && board[2][0] == TileState.empty) return Point(2, 0);
    if (board[2][0] == opponent && board[0][2] == TileState.empty) return Point(0, 2);
    return null;
  }

  Point<int>? _findEmptyCorner(List<List<TileState>> board) {
    if (board[0][0] == TileState.empty) return Point(0, 0);
    if (board[0][2] == TileState.empty) return Point(0, 2);
    if (board[2][0] == TileState.empty) return Point(2, 0);
    if (board[2][2] == TileState.empty) return Point(2, 2);
    return null;
  }

  Point<int> _findEmptySide(List<List<TileState>> board) {
    if (board[0][1] == TileState.empty) return Point(0, 1);
    if (board[1][0] == TileState.empty) return Point(1, 0);
    if (board[1][2] == TileState.empty) return Point(1, 2);
    return Point(2, 1); // Default to a side if nothing else is available
  }

  bool _isValidMove(List<List<TileState>> board, Point<int> move) {
    return board[move.x][move.y] == TileState.empty;
  }
}
