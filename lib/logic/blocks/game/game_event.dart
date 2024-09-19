import 'package:equatable/equatable.dart';
import 'game_state.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class StartGame extends GameEvent {}

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
