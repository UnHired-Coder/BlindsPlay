import 'package:blindsplay/network/repository/login/UserRepository.dart';
import 'package:blindsplay/presentation/screens/mainscreen/mobile/MainMobile.dart';
import 'package:blindsplay/presentation/screens/mainscreen/web/MainWeb.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/colors.dart';
import '../../ui/widgets/common.dart';
import '../tabs/tabs.dart';

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

  Widget _buildLayout(isWeb) {
    return isWeb
        ? WebLayout(
            selectedIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
            tabs: APP_TABS)
        : MobileLayout(
            selectedIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
            pageWidgets: APP_TABS,
            userRepository: GetIt.I<UserRepository>(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWeb = (constraints.maxWidth > 1000);

      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: isWeb
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: CustomAppBar(isWeb))
              : const SizedBox.shrink(),
        ),
        body: _buildLayout(isWeb),
      );
    });
  }
}
