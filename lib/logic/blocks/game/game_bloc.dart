import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    // Register the event handlers
    on<StartGame>(_onStartGame);
    on<MakeMove>(_onMakeMove);
    on<HideMove>(_onHideMove);  // New handler for HideMove event
    on<EndGame>(_onEndGame);
    on<UpdateBoard>(_onUpdateBoard);
  }

  // Event handler for StartGame event
  void _onStartGame(StartGame event, Emitter<GameState> emit) {
    List<List<String>> initialBoard = List.generate(3, (_) => List.generate(3, (_) => ""));
    List<List<String>> visibleBoard = List.generate(3, (_) => List.generate(3, (_) => ""));
    emit(GameInProgress(initialBoard, visibleBoard, "X"));
  }

  // Event handler for MakeMove event
  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final updatedBoard = List<List<String>>.from(currentState.board);
      final updatedVisibleBoard = List<List<String>>.from(currentState.visibleBoard);

      if (updatedBoard[event.x][event.y].isEmpty) {
        updatedBoard[event.x][event.y] = currentState.currentPlayer;
        updatedVisibleBoard[event.x][event.y] = currentState.currentPlayer;

        // Emit the state immediately so the UI updates
        emit(GameInProgress(updatedBoard, updatedVisibleBoard, currentState.currentPlayer));
        await Future.microtask(() {});


        // Dispatch the HideMove event after 3 seconds
        Future.delayed(Duration(seconds: 3)).then((_) {
          add(HideMove(event.x, event.y));
        });
      }
    }
  }

  // Event handler for HideMove event
  void _onHideMove(HideMove event, Emitter<GameState> emit) {
    final currentState = state;
    if (currentState is GameInProgress) {
      final updatedVisibleBoard = List<List<String>>.from(currentState.visibleBoard);

      // Turn the selected box red after the delay
      updatedVisibleBoard[event.x][event.y] = "red";

      // Check if the game should continue or end (in case of winner or draw)
      final nextPlayer = currentState.currentPlayer == "X" ? "O" : "X";
      emit(GameInProgress(currentState.board, updatedVisibleBoard, nextPlayer));
    }
  }

  // Event handler for EndGame event
  void _onEndGame(EndGame event, Emitter<GameState> emit) {
    emit(GameOver(event.result));
  }

  // Event handler for UpdateBoard event
  void _onUpdateBoard(UpdateBoard event, Emitter<GameState> emit) {
    List<List<String>> visibleBoard = List.generate(3, (_) => List.generate(3, (_) => ""));
    emit(GameInProgress(event.board, visibleBoard, "X"));
  }
}
