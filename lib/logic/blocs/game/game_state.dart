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

class GameInitial extends GameState {
  const GameInitial();
}

class GameWaiting extends GameState {
  final int countdown;

  const GameWaiting(this.countdown);

  @override
  List<Object?> get props => [countdown];
}

class GameInProgress extends GameState {
  final List<List<TileState>> board;
  final List<List<TileState>> visibleBoard;
  final TileState currentPlayer;
  final bool active;
  final int elapsedTime;
  final List<List<String>> placeHolders;

  const GameInProgress({
    required this.board,
    required this.visibleBoard,
    required this.currentPlayer,
    this.active = true,
    this.elapsedTime = 0,
    required this.placeHolders,
  });

  @override
  List<Object?> get props =>
      [board, visibleBoard, currentPlayer, active, elapsedTime, placeHolders];

  GameInProgress copyWith({
    List<List<TileState>>? board,
    List<List<TileState>>? visibleBoard,
    TileState? currentPlayer,
    bool? active,
    int? elapsedTime,
    List<List<String>>? placeHolders,
  }) {
    return GameInProgress(
      board: board ?? this.board,
      visibleBoard: visibleBoard ?? this.visibleBoard,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      active: active ?? this.active,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      placeHolders: placeHolders ?? this.placeHolders,
    );
  }
}

class GameOver extends GameState {
  final String result;
  final List<List<TileState>> finalBoard;
  final int elapsedTime;
  final int moveCount;

  const GameOver({
    required this.result,
    required this.finalBoard,
    required this.elapsedTime,
    required this.moveCount,
  });

  @override
  List<Object?> get props => [result, finalBoard, elapsedTime, moveCount];
}

class GameError extends GameState {
  final String error;

  const GameError(this.error);

  @override
  List<Object?> get props => [error];
}
