import 'package:blindsplay/presentation/screens/tabs/about_page.dart';
import 'package:blindsplay/presentation/screens/tabs/home_page.dart';
import 'package:flutter/material.dart';

import '../../../logic/blocs/game/game_state.dart';
import '../../model/PageModel.dart';
import '../game/GamePage.dart';
import 'leaderboard_page.dart';
import 'profile_page.dart';

const List<PageNavModel> pageNavDestinations = [
  PageNavModel(
    title: 'Play Game',
    icon: 'assets/ic_play.png',
    page: GamePage(boardSize: 3, gameMode: GameMode.offline2Players),
  ),
  PageNavModel(
    title: 'Leaderboard',
    icon: 'assets/ic_play.png',
    page: LeaderboardPage(),
  ),
  PageNavModel(
    title: 'Profile',
    icon: 'assets/ic_play.png',
    page: ProfilePage(),
  ),
  PageNavModel(
    title: 'Help',
    icon: 'assets/ic_play.png',
    page: AboutPage(),
  ),
];

List<Widget> APP_TABS = <Widget>[
  HomePage(
      pages: pageNavDestinations,
      navigateToPage: (index, context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => pageNavDestinations[index].page,
          ),
        );
      }),
  const LeaderboardPage(),
  const ProfilePage(),
  const AboutPage()
];
