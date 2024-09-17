import 'package:blindsplay/config/colors.dart';
import 'package:blindsplay/presentation/screens/about_page.dart';
import 'package:blindsplay/presentation/screens/game_page.dart';
import 'package:blindsplay/presentation/screens/profile_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/button_styles.dart';
import '../../config/text_styles.dart';
import '../../logic/blocks/game/game_bloc.dart';
import '../ui/widgets/CustomNavItemUi.dart';
import 'home_page.dart';
import 'leaderboard_page.dart';

final List<Map<String, dynamic>> pages = [
  {
    'title': 'Play Game',
    'icon': 'assets/ic_play.png',
    'page': BlocProvider(
      create: (context) => GameBloc(),
      child: GamePage(),
    ),
  },
  {
    'title': 'Leaderboard',
    'icon': 'assets/ic_play.png',
    'page': LeaderboardPage(),
  },
  {
    'title': 'Profile',
    'icon': 'assets/ic_play.png',
    'page': ProfilePage(),
  },
  {
    'title': 'Help',
    'icon': 'assets/ic_play.png',
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
      backgroundColor: AppColors.primary,
      appBar: PreferredSize(
          preferredSize: kIsWeb ? Size.fromHeight(100) : Size.zero,
          child: Padding(
            padding: kIsWeb
                ? EdgeInsets.symmetric(horizontal: 150, vertical: 20)
                : EdgeInsets.zero,
            child: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.primary,
              title: Text('Blind Moves',
                  style:
                      AppTextStyles.heading2.copyWith(color: AppColors.accent)),
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
          )),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: AppColors.primary,
            extended: true,
            minWidth: 300,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onTabSelected,
            useIndicator: false,
            labelType: NavigationRailLabelType.none,
            destinations: pages.mapIndexed((idx, toElement) {
              return NavigationRailDestination(
                  icon: CustomNavItemUi(
                      isSelected: _selectedIndex == idx,
                      label: toElement['title'],
                      imageUrl: toElement['icon']),
                  label: const SizedBox.shrink());
            }).toList(),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
        color: AppColors.primary,
        child: ListView.builder(
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
                    Image(image: AssetImage(pages[index]['icon']),),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
