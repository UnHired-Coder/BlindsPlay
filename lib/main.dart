import 'package:blindsplay/presentation/screens/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_theme.dart';
import 'logic/blocks/game/game_bloc.dart';
import 'presentation/screens/home_page.dart';
import 'presentation/screens/profile_page.dart';
import 'presentation/screens/game_page.dart';
import 'presentation/screens/leaderboard_page.dart';

void main() {
  runApp(MyApp());
}

final List<Map<String, dynamic>> pages = [
  {
    'title': 'About Page',
    'icon': Icons.info,
    'page': AboutPage(),
  },
  {
    'title': 'Game',
    'icon': Icons.gamepad,
    'page': BlocProvider(
      create: (context) => GameBloc(),
      child: GamePage(),
    ),
  },
  {
    'title': 'Leaderboard',
    'icon': Icons.leaderboard,
    'page': LeaderboardPage(),
  },
  {
    'title': 'Profile',
    'icon': Icons.person,
    'page': ProfilePage(),
  },
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: AppTheme.theme,
      home: HomePage(
        pages: pages,
        navigateToPage: (index, _context) {
          Navigator.push(
            _context,
            MaterialPageRoute(
              builder: (context) => pages[index]['page'] as Widget,
            ),
          );
        },
      ),
    );
  }
}
