import 'package:blindsplay/config/screen_size.dart';
import 'package:flutter/material.dart';

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/tic_tac_toe_anim.png'),
          width: ScreenSize.screenWidth / 4,
        ),
      ],
    );
  }
}
