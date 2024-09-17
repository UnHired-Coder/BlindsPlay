import 'package:blindsplay/presentation/screens/about_page.dart';
import 'package:blindsplay/presentation/screens/game_page.dart';
import 'package:blindsplay/presentation/screens/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/button_styles.dart';
import '../../config/text_styles.dart';
import '../../logic/blocks/game/game_bloc.dart';
import 'home_page.dart';
import 'leaderboard_page.dart';

final List<Map<String, dynamic>> pages = [
  {
    'title': 'Play Game',
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
  {
    'title': 'Help',
    'icon': Icons.question_mark,
    'page': AboutPage(),
  },
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blind Moves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child: MainScreen()),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(
        pages: pages,
        navigateToPage: (index, _context) {
          Navigator.push(
            _context,
            MaterialPageRoute(
              builder: (context) => pages[index]['page'] as Widget,
            ),
          );
        }),
    LeaderboardPage(),
    ProfilePage(),
    AboutPage()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blind Moves', style: AppTextStyles.heading1),
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding if needed
          child: Image.asset(
            "assets/favicon.png",
            width: 40,
            height: 30,
          ),
        ),
        centerTitle: !kIsWeb, // Center on mobile, start-aligned on web
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: <Widget>[
        NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onTabSelected,
          useIndicator: false,
          labelType: NavigationRailLabelType.selected,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home_filled),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.leaderboard),
              selectedIcon: Icon(Icons.leaderboard_outlined),
              label: Text('Leaderboard'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person_outline),
              label: Text('Profile'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.help),
              selectedIcon: Icon(Icons.help_outline),
              label: Text('Help'),
            ),
          ],
        ),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(40.0),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pages[index]['page'] as Widget,
                ),
              );
            },
            style: secondaryButtonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pages[index]['title'],
                  style: AppTextStyles.button,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                Icon(pages[index]['icon']),
              ],
            ),
          ),
        );
      },
    );
  }
}

