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
  late String _roomID;

  OnlineGameBloc({required this.gameMode, required this.gameRepository})
      : super(const GameInitial()) {
    // Register the event handlers
    on<StartGame>(_onPrepareForMatch);
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
  Future<void> _onPrepareForMatch(
      StartGame event, Emitter<GameState> emit) async {
    gameMode = event.gameMode;

    emit(const GameInitial());

    MatchingStartedData matchingStartedData =
        await gameRepository.findMatch(playerID);

    gameRepository.match(
        playerID, matchingStartedData.waitlistId, _onServerEvent);
  }

  void _onServerEvent(BaseResponse serverEvent) async {
    switch (serverEvent.eventType) {
      case EventType.playerMatched:
        {
          final playerMatchedData = (serverEvent.data as PlayerMatchedData);
          assignedLabel = getTileStateFromSymbol(
              playerMatchedData.initialGameData.assignedLabel);

          _roomID = playerMatchedData.roomId;

          print("AssignedLabel :$assignedLabel, RoomID $_roomID");

          gameRepository.playGame(_roomID, _onServerEvent);
          gameRepository.joinRoom(playerID, _roomID);
        }
      case EventType.joinedRoom:
        {
          final joinedRoomData = (serverEvent.data as JoinedRoomData);
          print(joinedRoomData);
        }
      case EventType.startGame:
        {
          final boardGameState = (serverEvent.data as BoardGameState);
          print("Starting game...");
          print(boardGameState.board);

          TileState currentPlayer =
              getTileStateFromSymbol(boardGameState.currentPlayer);
          emit(GameInProgress(
              board: convertToTileState(boardGameState.board),
              visibleBoard: convertToTileState(boardGameState.visibleBoard),
              currentPlayer: currentPlayer,
              placeHolders: placeHolders,
              active: currentPlayer == assignedLabel));
        }
      case EventType.makeMove:
        {
          final boardGameState = (serverEvent.data as BoardGameState);
          print("Opponent made a move!");

          TileState currentPlayer =
              getTileStateFromSymbol(boardGameState.currentPlayer);

          List<List<TileState>> board =
              convertToTileState(boardGameState.board);
          List<List<TileState>> visibleBoard =
              convertToTileState(boardGameState.visibleBoard);

          add(PlaySound(currentPlayer == TileState.X ? "X" : "O"));
          _moveCount++;

          await Future.delayed(const Duration(
              milliseconds: AppConstants.delayToHide)); //Simulate API/ Socket

          emit(GameInProgress(
              board: board,
              visibleBoard: visibleBoard,
              currentPlayer: currentPlayer,
              placeHolders: placeHolders,
              active: currentPlayer == assignedLabel));

          if (boardGameState.isDraw) {
            // Game End: Draw
            const result = "It's a draw!";
            emit(GameOver(
                result: result,
                finalBoard: board,
                elapsedTime: timerBloc.state,
                moveCount: _moveCount));
          }

          TileState winner = getTileStateFromSymbol(boardGameState.winner);

          if (winner != TileState.empty) {
            // Game End
            final result = "Player ${winner.symbol} wins!";
            emit(GameOver(
                result: result,
                finalBoard: board,
                elapsedTime: timerBloc.state,
                moveCount: _moveCount));
          }
        }
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
      currentState.visibleBoard[event.x][event.y] = currentState.currentPlayer;

      emit(GameInProgress(
          board: currentState.board,
          visibleBoard: currentState.visibleBoard,
          currentPlayer: currentState.currentPlayer,
          placeHolders: placeHolders,
          active: currentState.currentPlayer == assignedLabel));

      gameRepository.makeMove(playerID, _roomID, event.x, event.y);
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
      await _onOnlineOpponentMakesMove(emit);
    }
  }

  Future<void> _onOnlineOpponentMakesMove(Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      await Future.delayed(Duration(seconds: 4)); //Simulate API/ Socket

      final newState = currentState.copyWith(active: true);
      emit(newState);
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

  List<List<TileState>> convertToTileState(List<List<String>> board) {
    return board.map((row) {
      return row.map((symbol) => getTileStateFromSymbol(symbol)).toList();
    }).toList();
  }
}
