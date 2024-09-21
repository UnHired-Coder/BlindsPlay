import 'package:blindsplay/config/screen_size.dart';
import 'package:flutter/material.dart';

Widget HomeScreenBanner() {
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
