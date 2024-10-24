import 'package:equatable/equatable.dart';

import 'game_state.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class WaitingToStart extends GameEvent {
  final int countdown;

  const WaitingToStart(this.countdown);

  @override
  List<Object?> get props => [countdown];
}

class StartGame extends GameEvent {
  final GameMode gameMode;

  const StartGame(this.gameMode);

  @override
  List<Object?> get props => [gameMode];
}

class MakeMove extends GameEvent {
  final int x, y;
  const MakeMove(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}

class HideMove extends GameEvent {
  final int x, y;
  const HideMove(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}

class EndGame extends GameEvent {
  final String result;
  const EndGame(this.result);

  @override
  List<Object?> get props => [result];
}

class UpdateBoard extends GameEvent {
  final List<List<TileState>> board;
  const UpdateBoard(this.board);

  @override
  List<Object?> get props => [board];
}

class ConnectionError extends GameEvent {
  final String error;
  const ConnectionError(this.error);

  @override
  List<Object?> get props => [error];
}

class PlaySound extends GameEvent {
  final String
      soundType; // You can define different sound types for X and O if needed

  const PlaySound(this.soundType);

  @override
  List<Object?> get props => [soundType];
}

class UpdateGameProgress extends GameEvent {
  final List<List<TileState>>? board;
  final List<List<TileState>>? visibleBoard;
  final TileState currentPlayer;
  final bool? active;
  final List<List<String>>? placeHolders;
  final int? elapsedTime;

  const UpdateGameProgress({
    this.board,
    this.visibleBoard,
    required this.currentPlayer,
    this.active,
    this.placeHolders,
    this.elapsedTime,
  });

  @override
  List<Object?> get props =>
      [board, visibleBoard, currentPlayer, active, placeHolders, elapsedTime];
}

class GameStarted extends GameEvent {
  final List<List<TileState>> board;
  final List<List<TileState>> visibleBoard;
  final TileState currentPlayer;
  final bool active;

  const GameStarted({
    required this.board,
    required this.visibleBoard,
    required this.currentPlayer,
    required this.active,
  });

  @override
  List<Object?> get props => [board, visibleBoard, currentPlayer, active];
}

class GameProgressUpdated extends GameEvent {
  final List<List<TileState>> board;
  final List<List<TileState>> visibleBoard;
  final TileState currentPlayer;
  final bool active;
  final int moveCount;

  const GameProgressUpdated({
    required this.board,
    required this.visibleBoard,
    required this.currentPlayer,
    required this.active,
    required this.moveCount,
  });

  @override
  List<Object?> get props =>
      [board, visibleBoard, currentPlayer, active, moveCount];
}

class GameFinished extends GameEvent {
  final String result;
  final List<List<TileState>> finalBoard;
  final int elapsedTime;
  final int moveCount;

  const GameFinished({
    required this.result,
    required this.finalBoard,
    required this.elapsedTime,
    required this.moveCount,
  });

  @override
  List<Object?> get props => [result, finalBoard, elapsedTime, moveCount];
}
