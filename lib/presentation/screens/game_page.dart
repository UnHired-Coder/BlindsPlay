import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocks/game/game_bloc.dart';
import '../../logic/blocks/game/game_state.dart';


class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Page'),
      ),
      body: BlocProvider(
        create: (context) => GameBloc(),
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameInitial) {
              return Center(
                child: Text(
                  'Start a new game!',
                  style: TextStyle(fontSize: 24),
                ),
              );
            } else if (state is GameInProgress) {
              return Center(
                child: Text(
                  'Game in Progress',
                  style: TextStyle(fontSize: 24),
                ),
              );
            } else if (state is GameOver) {
              return Center(
                child: Text(
                  'Game Over: ${state.result}',
                  style: TextStyle(fontSize: 24),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Unknown State',
                  style: TextStyle(fontSize: 24),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}