import 'package:blindsplay/config/constants.dart';
import 'package:flutter/material.dart';

class VerticalGameBar extends StatelessWidget {
  const VerticalGameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants.boardWidth,
        height: AppConstants.barWidth,
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
  const HorizontalGameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants.barWidth,
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
