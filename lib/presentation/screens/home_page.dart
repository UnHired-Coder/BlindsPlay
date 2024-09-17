import 'package:blindsplay/config/button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../config/colors.dart';
import '../../config/text_styles.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> pages;
  final Function(int, BuildContext) navigateToPage;

  HomePage({required this.pages, required this.navigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      body: Center(
        child: Text('About Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
