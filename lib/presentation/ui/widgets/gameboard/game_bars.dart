import 'package:blindsplay/config/constants.dart';
import 'package:flutter/material.dart';

class VerticalGameBar extends StatelessWidget {
  final double barThickness;

  const VerticalGameBar({super.key, required this.barThickness});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants.boardWidth,
        height: barThickness,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff7e664c), Color(0xfff4b059)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius:
              BorderRadius.circular(5), // Set the circular radius here
        ));
  }
}

class HorizontalGameBar extends StatelessWidget {
  final double barThickness;

  const HorizontalGameBar({super.key, required this.barThickness});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: barThickness,
        height: AppConstants.boardWidth,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xff7e664c), Color(0xfff4b059)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius:
              BorderRadius.circular(5), // Set the circular radius here
        ));
  }
}
