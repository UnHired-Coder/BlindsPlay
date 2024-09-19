import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final List<List<String>> board;       // Holds the actual board state (Xs and Os)
  final List<List<String>> visibleBoard; // Holds the visible board with red boxes for hidden Xs and Os
  final String currentPlayer;

  GameInProgress(this.board, this.visibleBoard, this.currentPlayer);

  @override
  List<Object?> get props => [board, visibleBoard, currentPlayer];
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
