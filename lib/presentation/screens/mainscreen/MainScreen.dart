import 'package:blindsplay/presentation/screens/mainscreen/mobile/MainMobile.dart';
import 'package:blindsplay/presentation/screens/mainscreen/web/MainWeb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../config/colors.dart';
import '../../../config/text_styles.dart';
import '../pages.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.primary,
      title: Text(
        'TicTac Memo',
        style: AppTextStyles.heading2.copyWith(color: AppColors.accent),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/favicon.png",
          width: 40,
          height: 30,
        ),
      ),
      centerTitle: !kIsWeb,
    );
  }

  Widget _buildLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return WebLayout(
            selectedIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
            tabs: APP_TABS,
          );
        } else {
          return MobileLayout(
            selectedIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
            pageWidgets: APP_TABS,
          );
        }
      },
    );
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
          child: _buildAppBar(),
        ),
      ),
      body: _buildLayout(),
    );
  }
}
