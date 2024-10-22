import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:blindsplay/logic/blocs/util/timer_block.dart';
import 'package:blindsplay/network/model/BaseResponse.dart';
import 'package:blindsplay/network/model/JoinedRoomData.dart';
import 'package:blindsplay/network/model/PlayerMatchedData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants.dart';
import '../../../network/model/Events.dart';
import '../../../network/model/MatchingStartedData.dart';
import '../../../network/repository/GameRepository.dart';
import '../util/tic_tac_toe_pc_move_helper.dart';
import 'game_event.dart';
import 'game_state.dart';

class OnlineGameBloc extends Bloc<GameEvent, GameState> {
  final TimerBloc timerBloc = TimerBloc();
  GameMode gameMode; // Add GameMode as a final property

  late List<List<String>> placeHolders =
      List.generate(3, (_) => List.generate(3, (_) => ""));
  int _moveCount = 0;

  final GameRepository gameRepository;
  TileState? assignedLabel;

  OnlineGameBloc({required this.gameMode, required this.gameRepository})
      : super(const GameInitial()) {
    // Register the event handlers
    on<StartGame>(_onStartGame);
    on<MakeMove>(_onMakeMove);
    on<HideMove>(_onHideMove);
    on<EndGame>(_onEndGame);
    on<UpdateBoard>(_onUpdateBoard);
    on<PlaySound>(_onPlaySound);
    on<WaitingToStart>(_onStartWaiting);

    randomizePlaceholders();

    // Listen to TimerBloc state and emit new elapsed time
    timerBloc.stream.listen((elapsedTime) {
      if (state is GameInProgress) {
        final currentState = state as GameInProgress;
        // Emit updated state with new elapsed time
        final newState = currentState.copyWith(elapsedTime: elapsedTime);
        emit(newState);
      }
    });
  }

  final playerID = 1;

  // Event handler for StartGame event
  Future<void> _onStartGame(StartGame event, Emitter<GameState> emit) async {
    gameMode = event.gameMode;

    emit(const GameInitial());

    MatchingStartedData matchingStartedData =
        await gameRepository.findMatch(playerID);

    gameRepository.match(
        playerID, matchingStartedData.waitlistId, _onServerEvent);
  }

  void _onServerEvent(BaseResponse serverEvent) {
    switch (serverEvent.eventType) {
      case EventType.playerMatched:
        {
          final playerMatchedData = (serverEvent.data as PlayerMatchedData);
          assignedLabel = getTileStateFromSymbol(
              playerMatchedData.initialGameData.assignedLabel);

          gameRepository.playGame(playerMatchedData.roomId, _onServerEvent);
          gameRepository.joinRoom(playerID, playerMatchedData.roomId);
        }
      case EventType.joinedRoom:
        {
          final playerMatchedData = (serverEvent.data as JoinedRoomData);
          print(playerMatchedData);

          add(const WaitingToStart(AppConstants.waitingToStartTime));
        }
      case EventType.startGame:
        {
          final boardGameState = (serverEvent.data as BoardGameState);
          print("Starting game...");
          print(boardGameState.board);
        }
      case EventType.makeMove:
        {}
      default:
        {}
    }
  }

  // Event handler for StartWaiting event
  Future<void> _onStartWaiting(
      WaitingToStart event, Emitter<GameState> emit) async {
    // Start the countdown timer
    timerBloc.startCountdown(Duration(seconds: event.countdown));

    // Emit the waiting state
    for (int i = 0; i < event.countdown; i++) {
      await Future.delayed(const Duration(seconds: 1));
      emit(GameWaiting(event.countdown - i - 1));
    }

    timerBloc.startCountdown(const Duration(days: 1));
  }

  // Event handler for MakeMove event
  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      if (currentState.board[event.x][event.y] == TileState.empty) {
        final newState = currentState.copyWith(active: false);
        newState.board[event.x][event.y] = newState.currentPlayer;
        newState.visibleBoard[event.x][event.y] = newState.currentPlayer;
        // Emit the updated state
        emit(newState);

        // Dispatch the PlaySound event
        add(PlaySound(newState.currentPlayer == TileState.X ? "X" : "O"));

        // Increment the move count
        _moveCount++;

        await Future.microtask(() {});

        // Dispatch the HideMove event based on the mode
        if (gameMode == GameMode.onlineMultiplayer) {
          await Future.delayed(const Duration(seconds: 1));
        }

        await Future.delayed(const Duration(
            milliseconds: AppConstants.delayToHide)); //Simulate API/ Socket
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

      final nextPlayer =
          currentState.currentPlayer == TileState.X ? TileState.O : TileState.X;

      final newState = currentState.copyWith(
          visibleBoard: updatedVisibleBoard,
          currentPlayer: nextPlayer,
          active: false,
          placeHolders: placeHolders);

      emit(newState);

      switch (gameMode) {
        case GameMode.offlineAgainstPC:
          await _onPCMakesMove(emit);
        case GameMode.onlineMultiplayer:
          await _onOnlineOpponentMakesMove(emit);
        case GameMode.offline2Players:
          await _onOpponentMakesMove(emit);
      }
    }
  }

  Future<void> _onPCMakesMove(Emitter<GameState> emit) async {
    final currentState = state;

    if (currentState is GameInProgress) {
      // Get the best move based on the smart move maker logic
      final move = _getBestMove(currentState.board, currentState.currentPlayer);

      if (move != null) {
        // Apply the move and update the state
        await _applyMove(emit, move.x.toInt(), move.y.toInt(), currentState);
      }

      await _onCheckWinner(emit);
    }
  }

// Step 1: Select the best move using smart move logic
  Point? _getBestMove(List<List<TileState>> board, TileState currentPlayer) {
    // Call the smart move maker logic defined earlier
    return TicTacToeHelper().getSmartMove(board, currentPlayer);
  }

// Step 2: Apply the move and update the game state
  Future<void> _applyMove(Emitter<GameState> emit, int row, int col,
      GameInProgress currentState) async {
    // Create a new game state with PC's move
    final newState = currentState.copyWith(active: false);

    // Simulate a delay before applying the move (for UX purposes)
    await Future.delayed(
        const Duration(milliseconds: AppConstants.delayToHide));

    // Update the board with the PC's move
    newState.board[row][col] = newState.currentPlayer;
    newState.visibleBoard[row][col] = newState.currentPlayer;

    // Increment the move count
    _moveCount++;

    // Emit the updated game state with PC's move
    emit(newState);

    // Play sound associated with the move (X or O)
    _playMoveSound(newState.currentPlayer);

    // Simulate a delay before hiding the move
    await Future.delayed(
        const Duration(milliseconds: AppConstants.delayToHide));

    // Update the board to show the red marker for the move
    await _highlightMove(emit, row, col, newState);
  }

// Step 3: Play sound based on the player's move
  void _playMoveSound(TileState player) {
    add(PlaySound(player == TileState.X ? "X" : "O"));
  }

// Step 4: Highlight the move and switch to the next player
  Future<void> _highlightMove(Emitter<GameState> emit, int row, int col,
      GameInProgress currentState) async {
    // Update the visible board to highlight the last move
    final updatedVisibleBoard =
        List<List<TileState>>.from(currentState.visibleBoard);
    updatedVisibleBoard[row][col] = TileState.red;

    // Switch to the next player
    final nextPlayer =
        currentState.currentPlayer == TileState.X ? TileState.O : TileState.X;

    // Emit the new state with updated board and switch to the next player
    final newState = currentState.copyWith(
        visibleBoard: updatedVisibleBoard,
        currentPlayer: nextPlayer,
        active: true);

    emit(newState);
  }

  Future<void> _onOnlineOpponentMakesMove(Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      await Future.delayed(Duration(seconds: 4)); //Simulate API/ Socket

      final newState = currentState.copyWith(active: true);
      emit(newState);
    }
  }

  Future<void> _onOpponentMakesMove(Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final newState = currentState.copyWith(active: true);
      emit(newState);
    }
  }

  // Check for winner after a move
  Future<void> _onCheckWinner(Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final board = currentState.board;

      // Check for winner in rows, columns, and diagonals
      TileState winner = _getWinner(board);

      final result = winner != TileState.empty
          ? "Player ${winner.symbol} wins!"
          : "It's a draw!";

      if (winner != TileState.empty || _isBoardFull(board)) {
        emit(GameOver(
            result: result,
            finalBoard: board,
            elapsedTime: timerBloc.state,
            moveCount: _moveCount));
      }
    }
  }

  // Event handler for EndGame event
  Future<void> _onEndGame(EndGame event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      emit(GameOver(
          result: event.result,
          finalBoard: currentState.board,
          elapsedTime: timerBloc.state,
          moveCount: _moveCount)); // Reset values for GameOver
    }
  }

  // Event handler for UpdateBoard event
  Future<void> _onUpdateBoard(
      UpdateBoard event, Emitter<GameState> emit) async {
    List<List<TileState>> visibleBoard =
        List.generate(3, (_) => List.generate(3, (_) => TileState.empty));
    emit(GameInProgress(
        board: event.board,
        visibleBoard: visibleBoard,
        currentPlayer: TileState.X,
        placeHolders: placeHolders));
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
    final player =
        AudioPlayer(); // assuming you're using the audio players package
    await player.play(AssetSource('placed_bait_click.mp3'), volume: 0.6);
  }

  @override
  Future<void> close() {
    timerBloc.close();
    return super.close();
  }

  randomizePlaceholders() {
    placeHolders =
        List.generate(3, (_) => List.generate(3, (_) => getRandomIcon()));

    Timer.periodic(
        const Duration(seconds: AppConstants.refreshPlaceholdersDuration),
        (timer) {
      placeHolders =
          List.generate(3, (_) => List.generate(3, (_) => getRandomIcon()));
    });
  }

  String getRandomIcon() {
    var rng = Random();
    return "assets/meme/${rng.nextInt(11) + 1}.png";
  }
}
