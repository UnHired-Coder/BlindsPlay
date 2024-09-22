import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:blindsplay/logic/blocks/util/timer_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final TimerBloc timerBloc = TimerBloc();
  StreamSubscription<int>? _timerSubscription;
  int _moveCount = 0;

  GameBloc() : super(const GameInitial(onlineMode: true)) {
    // Register the event handlers
    on<StartGame>(_onStartGame);
    on<MakeMove>(_onMakeMove);
    on<HideMove>(_onHideMove);
    on<EndGame>(_onEndGame);
    on<UpdateBoard>(_onUpdateBoard);
    on<PlaySound>(_onPlaySound);
    on<WaitingToStart>(_onStartWaiting);

    // Listen to TimerBloc state and emit new elapsed time
    _timerSubscription = timerBloc.stream.listen((elapsedTime) {
      if (state is GameInProgress) {
        final currentState = state as GameInProgress;
        // Emit updated state with new elapsed time
        final newState = GameInProgress.copy(currentState, elapsedTime: elapsedTime);
        print(newState.elapsedTime);
        emit(newState);
      }
    });
  }

  // Event handler for StartGame event
  Future<void> _onStartGame(StartGame event, Emitter<GameState> emit) async {
    emit(const GameInitial(onlineMode: true));

    // Start waiting state with a countdown
    add(const WaitingToStart(5));
  }

  // Event handler for StartWaiting event
  Future<void> _onStartWaiting(WaitingToStart event, Emitter<GameState> emit) async {
    // Start the countdown timer
    timerBloc.startCountdown(Duration(seconds: event.countdown));

    // Emit the waiting state
    for (int i = 0; i < event.countdown; i++) {
      await Future.delayed(const Duration(seconds: 1));
      emit(GameWaiting(event.countdown - i - 1));
    }

    List<List<TileState>> initialBoard =
    List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    List<List<TileState>> visibleBoard =
    List.generate(3, (_) => List.generate(3, (_) => TileState.empty));

    emit(GameInProgress(initialBoard, visibleBoard, TileState.X));
    timerBloc.startCountdown(const Duration(days: 1));
  }


  // Event handler for MakeMove event
  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      // Create a deep copy of the current state
      final newState = GameInProgress.copy(currentState, isActive: false);

      // Modify the copied board and visibleBoard
      if (newState.board[event.x][event.y] == TileState.empty) {
        newState.board[event.x][event.y] = newState.currentPlayer;
        newState.visibleBoard[event.x][event.y] = newState.currentPlayer;

        // Increment the move count
        _moveCount++;

        // Emit the updated state
        emit(newState);

        // Dispatch the PlaySound event
        add(PlaySound(newState.currentPlayer == TileState.X ? "X" : "O"));

        await Future.microtask(() {});

        // Dispatch the HideMove event based on the mode
        if (newState.onlineMode) {
          await Future.delayed(const Duration(seconds: 1));
        }
        add(HideMove(event.x, event.y));

        // Check for winner after the move
        await _onCheckWinner(emit);
      }
    }
  }

  // Event handler for HideMove event
  Future<void> _onHideMove(HideMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final updatedVisibleBoard =
      List<List<TileState>>.from(currentState.visibleBoard);

      // Turn the selected box red after the delay
      updatedVisibleBoard[event.x][event.y] = TileState.red;

      // Switch to the next player
      final nextPlayer =
      currentState.currentPlayer == TileState.X ? TileState.O : TileState.X;

      emit(GameInProgress(currentState.board, updatedVisibleBoard, nextPlayer,
          active: true));
    }
  }

  // Check for winner after a move
  Future<void> _onCheckWinner(Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final board = currentState.board;

      // Check for winner in rows, columns, and diagonals
      TileState winner = _getWinner(board);

      if (winner != TileState.empty) {
        emit(GameOver(
            "Player ${winner.symbol} wins!", board, timerBloc.state, _moveCount));
      } else if (_isBoardFull(board)) {
        emit(GameOver("It's a draw!", board, timerBloc.state, _moveCount));
      }
    }
  }

  // Event handler for EndGame event
  Future<void> _onEndGame(EndGame event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      emit(GameOver(event.result, currentState.board, timerBloc.state,
          _moveCount)); // Reset values for GameOver
    }
  }

  // Event handler for UpdateBoard event
  Future<void> _onUpdateBoard(UpdateBoard event, Emitter<GameState> emit) async {
    List<List<TileState>> visibleBoard =
    List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    emit(GameInProgress(event.board, visibleBoard, TileState.X));
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
  Future<void> _onPlaySound(PlaySound event, Emitter<GameState> emit) async {
    await _playSound(event.soundType);
  }

  // Method to play the sound
  Future<void> _playSound(String soundType) async {
    final player = AudioPlayer(); // assuming you're using the audio players package
    await player.play('assets/placed_bait.mp3', isLocal: true, volume: 0.6);
  }

  @override
  Future<void> close() {
    timerBloc.close();
    return super.close();
  }
}
