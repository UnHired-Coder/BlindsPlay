import 'package:flutter/material.dart';

import '../../config/colors.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text('Profile', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

