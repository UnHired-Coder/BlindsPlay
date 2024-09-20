import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial(onlineMode: true)) {
    // Register the event handlers
    on<StartGame>(_onStartGame);
    on<MakeMove>(_onMakeMove);
    on<HideMove>(_onHideMove);
    on<EndGame>(_onEndGame);
    on<UpdateBoard>(_onUpdateBoard);
    on<PlaySound>(_onPlaySound);
  }

  // Event handler for StartGame event
  void _onStartGame(StartGame event, Emitter<GameState> emit) {
    List<List<TileState>> initialBoard =
        List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    List<List<TileState>> visibleBoard =
        List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    emit(GameInProgress(initialBoard, visibleBoard, TileState.X,
        (state as GameInitial).onlineMode));
  }

  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      // Create a deep copy of the current state
      final newState = GameInProgress.copy(currentState, false);

      // Modify the copied board and visibleBoard
      if (newState.board[event.x][event.y] == TileState.empty) {
        newState.board[event.x][event.y] = newState.currentPlayer;
        newState.visibleBoard[event.x][event.y] = newState.currentPlayer;

        // Emit the updated state (this ensures immutability and triggers UI update)
        emit(newState);

        // Dispatch the PlaySound event
        add(PlaySound(newState.currentPlayer == TileState.X ? "X" : "O"));

        await Future.microtask(() {});

        // Dispatch the HideMove event based on the mode
        if (newState.onlineMode) {
          Future.delayed(const Duration(seconds: 1), () {
            add(HideMove(event.x, event.y));
          });
        } else {
          add(HideMove(event.x, event.y));
        }

        // Dispatch the CheckWinner event after the move
        _onCheckWinner(emit);
      }
    }
  }

  // Event handler for HideMove event
  void _onHideMove(HideMove event, Emitter<GameState> emit) {
    final currentState = state;
    if (currentState is GameInProgress) {
      final updatedVisibleBoard =
          List<List<TileState>>.from(currentState.visibleBoard);

      // Turn the selected box red after the delay
      updatedVisibleBoard[event.x][event.y] = TileState.red;

      // Switch to the next player only after the move is hidden (red box)
      final nextPlayer =
          currentState.currentPlayer == TileState.X ? TileState.O : TileState.X;

      emit(GameInProgress(currentState.board, updatedVisibleBoard, nextPlayer,
          currentState.onlineMode, active: true));
    }
  }

  // Event handler for CheckWinner event
  void _onCheckWinner(Emitter<GameState> emit) {
    final currentState = state;
    if (currentState is GameInProgress) {
      final board = currentState.board;

      // Check for winner in rows, columns, and diagonals
      TileState winner = _getWinner(board);

      if (winner != TileState.empty) {
        emit(GameOver("Player ${winner.symbol} wins!"));
      } else if (_isBoardFull(board)) {
        emit(GameOver("It's a draw!"));
      }
    }
  }

  // Event handler for EndGame event
  void _onEndGame(EndGame event, Emitter<GameState> emit) {
    emit(GameOver(event.result));
  }

  // Event handler for UpdateBoard event
  void _onUpdateBoard(UpdateBoard event, Emitter<GameState> emit) {
    List<List<TileState>> visibleBoard =
        List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    emit(GameInProgress(event.board, visibleBoard, TileState.X,
        (state as GameInProgress).onlineMode));
  }

  TileState _getWinner(List<List<TileState>> board) {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != TileState.empty &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return board[i][0];
      }
      if (board[0][i] != TileState.empty &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return board[0][i];
      }
    }

    // Check diagonals
    if (board[0][0] != TileState.empty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != TileState.empty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2];
    }

    return TileState.empty; // No winner
  }

  bool _isBoardFull(List<List<TileState>> board) {
    for (var row in board) {
      for (var tile in row) {
        if (tile == TileState.empty) return false;
      }
    }
    return true;
  }

  // Event handler for PlaySound event
  void _onPlaySound(PlaySound event, Emitter<GameState> emit) async {
    // Use a sound package like audioplayers to play the sound
    await _playSound(event.soundType);
  }

// Method to play the sound
  Future<void> _playSound(String soundType) async {
    // Logic to play sound using audioplayers or any other sound package
    final player =
        AudioPlayer(); // assuming you're using the audioplayers package
    if (soundType == "X") {
      await player.play('assets/placed_bait.mp3', isLocal: true, volume: 0.6);
    } else {
      await player.play('assets/placed_bait.mp3', isLocal: true, volume: 0.6);
    }
  }
}
