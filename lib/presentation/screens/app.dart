import 'package:flutter/material.dart';
import '../../config/screen_size.dart';
import 'mainscreen/MainScreen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicTac Memo',
      home: Center(child: MainScreen()),
    );
  }
}