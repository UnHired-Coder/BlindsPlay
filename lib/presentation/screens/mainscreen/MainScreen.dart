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
      title: Row(
        children: [
          Image.asset(
            "assets/favicon.png",
            width: 57.4,
            height: 37.9,
          ),
          Text(
            'Tic Tac Memo',
            style: AppTextStyles.bodyText.copyWith(color: AppColors.onPrimary),
          )
        ],
      ),
      leading: null,
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
              ? EdgeInsets.symmetric(horizontal: 100, vertical: 20)
              : EdgeInsets.zero,
          child: _buildAppBar(),
        ),
      ),
      body: _buildLayout(),
    );
  }
}
