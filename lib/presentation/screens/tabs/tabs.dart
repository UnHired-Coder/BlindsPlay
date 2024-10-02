import 'package:blindsplay/presentation/screens/tabs/about_page.dart';
import 'package:blindsplay/presentation/screens/tabs/home_page.dart';
import 'package:flutter/material.dart';

import '../../../logic/blocs/game/game_state.dart';
import '../../model/PageModel.dart';
import '../game/game_page.dart';
import 'leaderboard_page.dart';
import 'profile_page.dart';

const List<PageNavModel> pageNavDestinations = [
  PageNavModel(
    title: 'Play Game',
    icon: 'assets/ic_play.png',
    page: GamePage(
        boardSize: 3,
        gameMode: GameMode
            .offline2Players), // This needs to be const or a const constructor if used
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
      navigateToPage: (index, _context) {
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => pageNavDestinations[index].page,
          ),
        );
      }),
  LeaderboardPage(),
  ProfilePage(),
  AboutPage()
];
