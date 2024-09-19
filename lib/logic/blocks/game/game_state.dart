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
}

class GameInitial extends GameState {
  final bool onlineMode;

  GameInitial(this.onlineMode);

  @override
  List<Object?> get props => [onlineMode];
}

class GameInProgress extends GameState {
  final List<List<TileState>> board; // Holds the actual board state (Xs and Os)
  final List<List<TileState>>
      visibleBoard; // Holds the visible board with red boxes for hidden Xs and Os
  final TileState currentPlayer;
  final bool onlineMode;

  GameInProgress(this.board, this.visibleBoard, this.currentPlayer, this.onlineMode);

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
