import 'package:equatable/equatable.dart';

enum TileState { empty, red, X, O }

extension TileStateExtension on TileState {
  String get symbol {
    switch (this) {
      case TileState.X:
        return "X";
      case TileState.O:
        return "O";
      case TileState.red:
        return "";
      default:
        return "";
    }
  }
}

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];

  final bool onlineMode;
  const GameState({this.onlineMode = true});
}

class GameInitial extends GameState {
  const GameInitial({required super.onlineMode});

  @override
  List<Object?> get props =>
      [onlineMode]; // This is optional, already inherited
}

class GameWaiting extends GameState {
  final int countdown;

  const GameWaiting(this.countdown, {bool onlineMode = true}) : super(onlineMode: onlineMode);

  @override
  List<Object?> get props => [countdown, onlineMode];
}

class GameInProgress extends GameState {
  final List<List<TileState>> board; // Holds the actual board state (Xs and Os)
  final List<List<TileState>>
      visibleBoard; // Holds the visible board with red boxes for hidden Xs and Os
  final TileState currentPlayer;
  final bool active;

  const GameInProgress(this.board, this.visibleBoard, this.currentPlayer,
      {this.active = true});

  @override
  List<Object?> get props => [board, visibleBoard, currentPlayer];

  GameInProgress.copy(GameInProgress other, isActive)
      : board = other.board.map((row) => List<TileState>.from(row)).toList(),
        visibleBoard =
            other.visibleBoard.map((row) => List<TileState>.from(row)).toList(),
        currentPlayer = other.currentPlayer,
        active = isActive;
}

class GameOver extends GameState {
  final String result;
  final List<List<TileState>> finalBoard; // Include the final board state
  final int elapsedTime; // Elapsed time in seconds
  final int moveCount; // Total moves made

  const GameOver(
      this.result, this.finalBoard, this.elapsedTime, this.moveCount);

  @override
  List<Object?> get props => [result, finalBoard, elapsedTime, moveCount];
}

class GameError extends GameState {
  final String error;

  const GameError(this.error);

  @override
  List<Object?> get props => [error];
}
