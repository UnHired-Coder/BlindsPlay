import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    // Register the event handlers
    on<StartGame>(_onStartGame);
    on<MakeMove>(_onMakeMove);
    on<EndGame>(_onEndGame);
    on<UpdateBoard>(_onUpdateBoard);
  }

  // Event handler for StartGame event
  void _onStartGame(StartGame event, Emitter<GameState> emit) {
    // Initialize an empty 3x3 board and set the current player to "X"
    List<List<String>> initialBoard = List.generate(3, (_) => List.generate(3, (_) => ""));
    // The visible board will hide the actual X and O after each move with a red box.
    List<List<String>> visibleBoard = List.generate(3, (_) => List.generate(3, (_) => ""));

    emit(GameInProgress(initialBoard, visibleBoard, "X"));
  }

  // Event handler for MakeMove event
  void _onMakeMove(MakeMove event, Emitter<GameState> emit) {
    final currentState = state;
    if (currentState is GameInProgress) {
      // Update the actual board with the player's move
      final updatedBoard = List<List<String>>.from(currentState.board);
      final updatedVisibleBoard = List<List<String>>.from(currentState.visibleBoard);

      if (updatedBoard[event.x][event.y].isEmpty) {
        updatedBoard[event.x][event.y] = currentState.currentPlayer;

        // Hide the move on the visible board by setting it to "red"
        updatedVisibleBoard[event.x][event.y] = "red";  // Represent the hidden X or O as a red box

        // Check if there's a winner or a draw
        if (_checkWinner(updatedBoard, currentState.currentPlayer)) {
          emit(GameOver("Player ${currentState.currentPlayer} wins!"));
        } else if (_isBoardFull(updatedBoard)) {
          emit(GameOver("It's a draw!"));
        } else {
          // Switch the turn to the next player
          final nextPlayer = currentState.currentPlayer == "X" ? "O" : "X";
          emit(GameInProgress(updatedBoard, updatedVisibleBoard, nextPlayer));
        }
      }
    }
  }

  // Event handler for UpdateBoard event
  void _onUpdateBoard(UpdateBoard event, Emitter<GameState> emit) {
    List<List<String>> visibleBoard = List.generate(3, (_) => List.generate(3, (_) => "red")); // Everything is hidden
    emit(GameInProgress(event.board, visibleBoard, "X"));  // Assume "X" starts the game
  }

  // Event handler for EndGame event
  void _onEndGame(EndGame event, Emitter<GameState> emit) {
    emit(GameOver(event.result));
  }

  // Utility method to check for a winner
  bool _checkWinner(List<List<String>> board, String currentPlayer) {
    // Check rows, columns, and diagonals for a winner
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer) {
        return true;
      }
      if (board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer) {
        return true;
      }
    }
    if (board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer) {
      return true;
    }
    if (board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  // Utility method to check if the board is full
  bool _isBoardFull(List<List<String>> board) {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }
}
