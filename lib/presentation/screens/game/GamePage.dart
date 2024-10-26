import 'package:amplitude_flutter/amplitude.dart';
import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/config/spacing.dart';
import 'package:blindsplay/logic/blocs/game/online_game_bloc.dart';
import 'package:blindsplay/network/model/Player.dart';
import 'package:blindsplay/network/repository/gmae/GameRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/constants.dart';
import '../../../logic/blocs/game/game_bloc.dart';
import '../../../logic/blocs/game/game_event.dart';
import '../../../logic/blocs/game/game_state.dart';
import '../../ui/effects/fade_in_widget.dart';
import '../../ui/widgets/gameboard/active_game_board.dart';
import '../../ui/widgets/gameboard/finished_game_board.dart';

class GamePage extends StatelessWidget {
  final int boardSize; // Dynamic board size
  final GameMode gameMode;

  const GamePage({Key? key, required this.boardSize, required this.gameMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amplitude = GetIt.I<Amplitude>();
    amplitude.logEvent("Open GamePage");

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: !kIsWeb ? _buildAppBar() : null,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GameBloc(gameMode: gameMode)
              ..add(StartGame(gameMode)), // Start game when the page is created
          ),
          BlocProvider(
            create: (context) => OnlineGameBloc(
                gameMode: gameMode,
                gameRepository: GetIt.I<GameRepository>(),
                playerID: FirebaseAuth.instance.currentUser!.uid)
              ..add(
                  StartGame(gameMode)), // Initialize something for AnotherBloc
          ),
        ], // Start game when the page is created
        child: _GameContent(boardSize: boardSize, gameMode: gameMode),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
        backgroundColor: AppColors.primary,
        title: const SizedBox.shrink(),
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.onPrimary);
  }
}

class _GameContent extends StatelessWidget {
  final int boardSize;
  final GameMode gameMode;

  const _GameContent({required this.boardSize, required this.gameMode});

  @override
  Widget build(BuildContext context) {
    final amplitude = GetIt.I<Amplitude>();

    if (gameMode == GameMode.onlineMultiplayer) {
      return BlocBuilder<OnlineGameBloc, GameState>(
        builder: (context, state) {
          if (state is GameInitial) {
            amplitude.logEvent("Game State GameInitial");

            return FadeInWidget(
                key: Key("GameWaiting"),
                child: _buildMessage('Searching for your opponent...'));
          } else if (state is GameWaiting) {
            amplitude.logEvent("Game State GameWaiting");

            return FadeInWidget(
                key: Key("GameInProgress"),
                child: _buildPlayerWaitingUi(
                    state.countdown, state.you, state.opponent));
          } else if (state is GameInProgress) {
            amplitude.logEvent("Game State GameInProgress");

            return FadeInWidget(
                key: Key("GameOver"),
                child: ActiveGameBoard(
                  state: state,
                  boardSize: boardSize,
                  onMakeMove: (posX, posY) {
                    BlocProvider.of<OnlineGameBloc>(context)
                        .add(MakeMove(posX, posY));
                  },
                ));
          } else if (state is GameOver) {
            amplitude.logEvent("Game State GameOver");

            return FadeInWidget(
                key: Key("GameError"),
                child: FinishedGameBoard(state: state, boardSize: boardSize));
          } else if (state is GameError) {
            amplitude.logEvent("Game State GameError");

            return _buildMessage('Error: ${state.error}');
          } else {
            amplitude.logEvent("Game State No State");

            return _buildMessage('Unknown State');
          }
        },
      );
    } else {
      return BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameInitial) {
            amplitude.logEvent("Game State GameInitial");

            return FadeInWidget(
                key: Key("GameWaiting"),
                child: _buildMessage('Searching for your opponent...'));
          } else if (state is GameWaiting) {
            amplitude.logEvent("Game State GameWaiting");

            return FadeInWidget(
                key: Key("GameInProgress"),
                child: _buildMessage('Game starts in : ${state.countdown}s'));
          } else if (state is GameInProgress) {
            amplitude.logEvent("Game State GameInProgress");

            return FadeInWidget(
                key: Key("GameOver"),
                child: ActiveGameBoard(
                    state: state,
                    boardSize: boardSize,
                    onMakeMove: (posX, posY) {
                      BlocProvider.of<GameBloc>(context)
                          .add(MakeMove(posX, posY));
                    }));
          } else if (state is GameOver) {
            amplitude.logEvent("Game State GameOver");

            return FadeInWidget(
                key: Key("GameError"),
                child: FinishedGameBoard(state: state, boardSize: boardSize));
          } else if (state is GameError) {
            amplitude.logEvent("Game State GameError");

            return _buildMessage('Error: ${state.error}');
          } else {
            amplitude.logEvent("Game State No State");

            return _buildMessage('Unknown State');
          }
        },
      );
    }
  }

  Widget _buildMessage(String message, {Color color = AppColors.onPrimary}) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
            fontSize: 20, color: color, fontFamily: AppConstants.fontFamily1),
      ),
    );
  }

  Widget _buildPlayerWaitingUi(
      int countdown, GamePlayer you, GamePlayer opponent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildPlayerCard(
                  imageUrl: "",
                  avatarUrl: "",
                  playerName: "You",
                  rating: you.rating.toString()),
              const SizedBox(width: AppSpacing.medium),
              _buildMessage('V/s', color: AppColors.success),
              const SizedBox(width: AppSpacing.medium),
              _buildPlayerCard(
                  imageUrl: "",
                  avatarUrl: "",
                  playerName: opponent.username,
                  rating: opponent.rating.toString()),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          _buildMessage('Game starts in : ${countdown}s')
        ],
      ),
    );
  }

  Widget _buildPlayerCard({
    required String imageUrl,
    String? avatarUrl,
    required String playerName,
    required String rating,
  }) {
    return Container(
      width: 90,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.greyDark,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.3), // Shadow color with opacity
                  spreadRadius: 2, // How much the shadow spreads
                  blurRadius: 8, // The blur effect of the shadow
                  offset: Offset(0, 4), // Position of the shadow (x, y)
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: AppColors.greyDark,
                      borderRadius: BorderRadius.circular(5)),
                ),
                if (avatarUrl != null)
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.secondary,
                            AppColors.primary,
                            AppColors.secondary,
                            AppColors.primary,
                            AppColors.secondary,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          transform: GradientRotation(
                              30 * 3.14 / 180), // 30 degrees to radians
                        ),
                        borderRadius: BorderRadius.circular(3)),
                  ),
                Positioned(
                  bottom: 10,
                  child: Column(
                    children: [
                      Text(
                        playerName,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 8,
                          fontFamily: AppConstants.fontFamily1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        rating,
                        style: const TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 10,
                          fontFamily: AppConstants.fontFamily1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
