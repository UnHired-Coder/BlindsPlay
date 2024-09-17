import 'package:flutter/material.dart';

import '../../config/colors.dart';

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text('Leaderboard Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}