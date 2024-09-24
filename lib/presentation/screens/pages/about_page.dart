import 'package:blindsplay/config/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text('About', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
