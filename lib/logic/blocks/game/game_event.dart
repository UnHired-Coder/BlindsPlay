// business/blocs/game/game_event.dart

import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartGame extends GameEvent {}

class MakeMove extends GameEvent {
  final int x;
  final int y;

  MakeMove(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}

class UpdateBoard extends GameEvent {
  final List<List<String>> board;

  UpdateBoard(this.board);

  @override
  List<Object?> get props => [board];
}

class EndGame extends GameEvent {
  final String result;

  EndGame(this.result);

  @override
  List<Object?> get props => [result];
}

class FetchGameState extends GameEvent {}

class ConnectionError extends GameEvent {
  final String error;

  ConnectionError(this.error);

  @override
  List<Object?> get props => [error];
}
