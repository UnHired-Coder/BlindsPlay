// business/blocs/game/game_state.dart

import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final List<List<String>> board;
  final String currentPlayer;

  GameInProgress(this.board, this.currentPlayer);

  @override
  List<Object?> get props => [board, currentPlayer];
}

class GameOver extends GameState {
  final String result;

  GameOver(this.result);

  @override
  List<Object?> get props => [result];
}

class GameError extends GameState {
  final String error;

  GameError(this.error);

  @override
  List<Object?> get props => [error];
}
