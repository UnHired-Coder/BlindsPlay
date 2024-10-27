import 'package:flutter/material.dart';

Widget HomeScreenBanner() {
  return LayoutBuilder(builder: (context, constraints) {
    final isWeb = constraints.maxWidth > 1000;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/tic_tac_toe_anim.png'),
          width: isWeb
              ? (constraints.maxWidth / 2.5)
              : (constraints.maxWidth * 0.8),
        ),
      ],
    );
  });
}
