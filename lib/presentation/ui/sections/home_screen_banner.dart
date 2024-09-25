import 'package:blindsplay/config/screen_size.dart';
import 'package:flutter/material.dart';

Widget HomeScreenBanner() {
  return LayoutBuilder(builder: (context, constraints) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/tic_tac_toe_anim.png'),
          width: constraints.maxWidth / 2.5,
        ),
      ],
    );
  });
}
