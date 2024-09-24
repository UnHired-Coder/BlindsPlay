import 'package:equatable/equatable.dart';

enum TileState { empty, red, X, O }

enum GameMode { offline2Players, offlineAgainstPC, onlineMultiplayer }

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

// Base GameState class
abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

// GameInitial state
class GameInitial extends GameState {
  const GameInitial();
}

// GameWaiting state
class GameWaiting extends GameState {
  final int countdown;

  const GameWaiting(this.countdown);

  @override
  List<Object?> get props => [countdown];
}

// GameInProgress state
class GameInProgress extends GameState {
  final List<List<TileState>> board; // Holds the actual board state (Xs and Os)
  final List<List<TileState>>
      visibleBoard; // Holds the visible board with red boxes for hidden Xs and Os
  final TileState currentPlayer;
  final bool active;
  final int elapsedTime;
  final List<List<String>> placeHolders;// Tracks the time elapsed since the game started

  const GameInProgress(this.board, this.visibleBoard, this.currentPlayer,
      {this.active = true, this.elapsedTime = 0, required this.placeHolders});

  @override
  List<Object?> get props =>
      [board, visibleBoard, currentPlayer, active, elapsedTime, placeHolders];

  // Copy constructor to allow creating a new GameInProgress state with modifications
  GameInProgress.copy(GameInProgress other,
      {bool? isActive, int? elapsedTime, TileState? nextPlayer})
      : board = _deepCopy(other.board),
        visibleBoard = _deepCopy(other.visibleBoard),
        currentPlayer = nextPlayer ?? other.currentPlayer,
        active = isActive ?? other.active,
        elapsedTime = elapsedTime ?? other.elapsedTime,
        placeHolders = _deepCopyString(other.placeHolders);

  // Deep copy method to maintain immutability of board states
  static List<List<TileState>> _deepCopy(List<List<TileState>> original) {
    return original.map((row) => List<TileState>.from(row)).toList();
  }

  // Deep copy method to maintain immutability of board states
  static List<List<String>> _deepCopyString(List<List<String>> original) {
    return original.map((row) => List<String>.from(row)).toList();
  }
}

// GameOver state
class GameOver extends GameState {
  final String result;
  final List<List<TileState>> finalBoard; // Final board state
  final int elapsedTime; // Total elapsed time in seconds
  final int moveCount; // Total moves made

  const GameOver(this.result, this.finalBoard, this.elapsedTime, this.moveCount,
      {bool onlineMode = true});

  @override
  List<Object?> get props => [result, finalBoard, elapsedTime, moveCount];
}

// GameError state
class GameError extends GameState {
  final String error;

  const GameError(this.error);

  @override
  List<Object?> get props => [error];
}
