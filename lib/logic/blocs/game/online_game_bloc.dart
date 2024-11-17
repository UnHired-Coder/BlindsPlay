import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:blindsplay/logic/blocs/util/timer_block.dart';
import 'package:blindsplay/network/model/BaseResponse.dart';
import 'package:blindsplay/network/model/PlayerMatchedData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants.dart';
import '../../../network/model/BoardState.dart';
import '../../../network/model/Events.dart';
import '../../../network/model/MatchingStartedData.dart';
import '../../../network/repository/gmae/GameRepository.dart';
import 'game_event.dart';
import 'game_state.dart';

class OnlineGameBloc extends Bloc<GameEvent, GameState> {
  final TimerBloc timerBloc = TimerBloc();
  GameMode gameMode; // Add GameMode as a final property
  String playerID;

  late List<List<String>> placeHolders =
      List.generate(3, (_) => List.generate(3, (_) => ""));
  int _moveCount = 0;

  final GameRepository gameRepository;
  TileState? assignedLabel;
  late String _roomID;

  OnlineGameBloc({
    required this.gameMode,
    required this.gameRepository,
    required this.playerID,
  }) : super(const GameInitial()) {
    on<StartGame>(_onPrepareForMatch);
    on<MakeMove>(_onMakeMove);
    on<HideMove>(_onHideMove);
    on<UpdateBoard>(_onUpdateBoard);
    on<PlaySound>(_onPlaySound);
    on<WaitingToStart>(_onStartWaiting);
    on<GameStarted>(_onGameStarted);
    on<GameProgressUpdated>(_onGameProgressUpdated);
    on<GameFinished>(_onGameFinished);

    randomizePlaceholders();

    timerBloc.stream.listen((elapsedTime) {
      if (state is GameInProgress) {
        final currentState = state as GameInProgress;
        final newState = currentState.copyWith(elapsedTime: elapsedTime);
        emit(newState);
      }
    });
  }

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

  late PlayerMatchedData playerMatchedData;

  void _onServerEvent(BaseResponse serverEvent) async {
    switch (serverEvent.eventType) {
      case EventType.playerMatched:
        {
          playerMatchedData = (serverEvent.data as PlayerMatchedData);
          assignedLabel = getTileStateFromSymbol(
              playerMatchedData.you.initialGameData.assignedLabel);

          _roomID = playerMatchedData.roomId;

          gameRepository.playGame(_roomID, _onServerEvent);
          gameRepository.joinRoom(playerID, _roomID);
        }
      case EventType.startGame:
        {
          final boardGameState = (serverEvent.data as BoardGameState);
          TileState currentPlayer =
              getTileStateFromSymbol(boardGameState.currentPlayer);

          _startGameAfterDelay(
            boardGameState: boardGameState,
            currentPlayer: currentPlayer,
            delayInSeconds: 5,
          );
        }
      case EventType.makeMove:
        {
          final boardGameState = (serverEvent.data as BoardGameState);
          TileState currentPlayer =
              getTileStateFromSymbol(boardGameState.currentPlayer);

          List<List<TileState>> board =
              convertToTileState(boardGameState.board);
          List<List<TileState>> visibleBoard =
              convertToTileState(boardGameState.visibleBoard);

          add(PlaySound(
              boardGameState.currentPlayer == TileState.X ? "X" : "O"));

          await Future.delayed(const Duration(seconds: 1));

          timerBloc.pause(currentPlayer != assignedLabel);

          add(GameProgressUpdated(
            board: board,
            visibleBoard: visibleBoard,
            currentPlayer: currentPlayer,
            active: currentPlayer == assignedLabel,
            moveCount: ++_moveCount,
          ));

          if (boardGameState.isDraw) {
            add(GameFinished(
                result: "It's a draw!",
                finalBoard: board,
                elapsedTime: timerBloc.state,
                moveCount: _moveCount,
                didIWin: null));
          }

          TileState winner = getTileStateFromSymbol(boardGameState.winner);

          if (winner != TileState.empty) {
            var didIWin = assignedLabel?.symbol == winner.symbol;
            add(GameFinished(
                result: _getWinnerText(didIWin),
                finalBoard: board,
                elapsedTime: timerBloc.state,
                moveCount: _moveCount,
                didIWin: didIWin));
          }
        }
      default:
        {}
    }
  }

  String _getWinnerText(bool didIWin) {
    if (didIWin) {
      return "You win!";
    } else {
      return "You lost!";
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
      emit(GameWaiting(event.countdown - i - 1, event.you, event.opponent));
    }

    timerBloc.startCountdown(const Duration(days: 1));
  }

  Future<void> _startGameAfterDelay({
    required BoardGameState boardGameState,
    required TileState currentPlayer,
    required int delayInSeconds,
  }) async {
    // Step 1: Fire the GameWaiting event with the countdown duration
    add(WaitingToStart(
        delayInSeconds, playerMatchedData.you, playerMatchedData.opponent));

    // Step 2: Wait for the specified duration
    await Future.delayed(Duration(seconds: delayInSeconds + 2));

    // Step 3: After the delay, fire the GameStarted event

    timerBloc.pause(currentPlayer != assignedLabel);

    if (!isClosed) {
      add(GameStarted(
        board: convertToTileState(boardGameState.board),
        visibleBoard: convertToTileState(boardGameState.visibleBoard),
        currentPlayer: currentPlayer,
        active: currentPlayer == assignedLabel,
      ));
    }
  }

  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      currentState.visibleBoard[event.x][event.y] = currentState.currentPlayer;

      add(GameProgressUpdated(
        board: currentState.board,
        visibleBoard: currentState.visibleBoard,
        currentPlayer: currentState.currentPlayer,
        active: currentState.currentPlayer == assignedLabel,
        moveCount: _moveCount,
      ));

      gameRepository.makeMove(playerID, _roomID, event.x, event.y);
    }
  }

  Future<void> _onHideMove(HideMove event, Emitter<GameState> emit) async {
    final currentState = state;
    if (currentState is GameInProgress) {
      final updatedVisibleBoard =
          List<List<TileState>>.from(currentState.visibleBoard);

      updatedVisibleBoard[event.x][event.y] = TileState.red;
      add(GameProgressUpdated(
        board: currentState.board,
        visibleBoard: updatedVisibleBoard,
        currentPlayer: currentState.currentPlayer,
        active: false,
        moveCount: _moveCount,
      ));
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

  void _onGameStarted(GameStarted event, Emitter<GameState> emit) {
    emit(GameInProgress(
      board: event.board,
      visibleBoard: event.visibleBoard,
      currentPlayer: event.currentPlayer,
      placeHolders: placeHolders,
      active: event.active,
    ));
  }

  void _onGameProgressUpdated(
      GameProgressUpdated event, Emitter<GameState> emit) {
    emit(GameInProgress(
      board: event.board,
      visibleBoard: event.visibleBoard,
      currentPlayer: event.currentPlayer,
      placeHolders: placeHolders,
      active: event.active,
      elapsedTime: timerBloc.state,
    ));
  }

  void _onGameFinished(GameFinished event, Emitter<GameState> emit) {
    gameRepository.updateScore(playerID, _roomID, assignedLabel?.symbol,
        event.elapsedTime, event.moveCount);

    emit(GameOver(
        result: event.result,
        finalBoard: event.finalBoard,
        elapsedTime: event.elapsedTime,
        moveCount: event.moveCount,
        didIWin: event.didIWin));
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
