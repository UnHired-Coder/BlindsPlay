import 'dart:math';

import 'package:blindsplay/config/constants.dart';

import '../game/game_state.dart';

class TicTacToeHelper {
  final int boardSize = AppConstants.boardSize;

  Point<int>? getSmartMove(
      List<List<TileState>> board, TileState currentPlayer) {
    TileState opponent =
        currentPlayer == TileState.X ? TileState.O : TileState.X;

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
    if (blockForkMove != null && _isValidMove(board, blockForkMove)) {
      return blockForkMove;
    }

    // 5. Take the center
    var center = Point((boardSize - 1) ~/ 2, (boardSize - 1) ~/ 2);
    if (_isValidMove(board, center)) return center;

    // 6. Take the opposite corner if opponent is in a corner
    var oppositeCorner = _takeOppositeCorner(board, opponent);
    if (oppositeCorner != null && _isValidMove(board, oppositeCorner)) {
      return oppositeCorner;
    }

    // 7. Take any empty corner
    var emptyCorner = _findEmptyCorner(board);
    if (emptyCorner != null && _isValidMove(board, emptyCorner)) {
      return emptyCorner;
    }

    // 8. Take any empty side
    return _findEmptySide(board);
  }

  Point<int>? _findWinningMove(List<List<TileState>> board, TileState player) {
    for (int i = 0; i < boardSize; i++) {
      // Check rows
      var rowMove = _checkLineForWin(board[i], player, i, isRow: true);
      if (rowMove != null) return rowMove;

      // Check columns
      var columnMove = _checkLineForWin(
          List.generate(boardSize, (j) => board[j][i]), player, i,
          isRow: false);
      if (columnMove != null) return columnMove;
    }

    // Check main diagonal
    var mainDiagonal = List.generate(boardSize, (i) => board[i][i]);
    var mainDiagonalMove = _checkDiagonalForWin(mainDiagonal, player);
    if (mainDiagonalMove != null) {
      return Point(mainDiagonalMove, mainDiagonalMove);
    }

    // Check anti-diagonal
    var antiDiagonal =
        List.generate(boardSize, (i) => board[i][boardSize - i - 1]);
    var antiDiagonalMove = _checkDiagonalForWin(antiDiagonal, player);
    if (antiDiagonalMove != null) {
      return Point(antiDiagonalMove, boardSize - antiDiagonalMove - 1);
    }

    return null;
  }

  Point<int>? _checkLineForWin(
      List<TileState> line, TileState player, int index,
      {bool isRow = true}) {
    if (_canWinLine(line, player)) {
      int emptyIndex = _findEmptyIndex(line);
      return isRow ? Point(index, emptyIndex) : Point(emptyIndex, index);
    }
    return null;
  }

  int? _checkDiagonalForWin(List<TileState> diagonal, TileState player) {
    if (_canWinLine(diagonal, player)) {
      return _findEmptyIndex(diagonal);
    }
    return null;
  }

  bool _canWinLine(List<TileState> line, TileState player) {
    int countPlayer = line.where((tile) => tile == player).length;
    int countEmpty = line.where((tile) => tile == TileState.empty).length;
    return countPlayer == boardSize - 1 && countEmpty == 1;
  }

  int _findEmptyIndex(List<TileState> line) {
    return line.indexOf(TileState.empty);
  }

  Point<int>? _findFork(List<List<TileState>> board, TileState player) {
    // Add logic to detect forks if needed for larger boards
    return null;
  }

  Point<int>? _takeOppositeCorner(
      List<List<TileState>> board, TileState opponent) {
    var corners = [
      [Point(0, 0), Point(boardSize - 1, boardSize - 1)],
      [Point(0, boardSize - 1), Point(boardSize - 1, 0)]
    ];

    for (var pair in corners) {
      if (board[pair[0].x][pair[0].y] == opponent &&
          _isValidMove(board, pair[1])) {
        return pair[1];
      }
      if (board[pair[1].x][pair[1].y] == opponent &&
          _isValidMove(board, pair[0])) {
        return pair[0];
      }
    }
    return null;
  }

  Point<int>? _findEmptyCorner(List<List<TileState>> board) {
    var corners = [
      Point(0, 0),
      Point(0, boardSize - 1),
      Point(boardSize - 1, 0),
      Point(boardSize - 1, boardSize - 1)
    ];

    for (var corner in corners) {
      if (_isValidMove(board, corner)) return corner;
    }
    return null;
  }

  Point<int>? _findEmptySide(List<List<TileState>> board) {
    for (int i = 1; i < boardSize - 1; i++) {
      if (_isValidMove(board, Point(0, i))) return Point(0, i); // Top side
      if (_isValidMove(board, Point(boardSize - 1, i))) {
        return Point(boardSize - 1, i); // Bottom side
      }
      if (_isValidMove(board, Point(i, 0))) return Point(i, 0); // Left side
      if (_isValidMove(board, Point(i, boardSize - 1))) {
        return Point(i, boardSize - 1); // Right side
      }
    }
    return null;
  }

  bool _isValidMove(List<List<TileState>> board, Point<int> move) {
    return move.x >= 0 &&
        move.x < boardSize &&
        move.y >= 0 &&
        move.y < boardSize &&
        board[move.x][move.y] == TileState.empty;
  }
}
