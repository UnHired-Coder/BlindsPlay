import 'dart:async';

import 'package:flutter/material.dart';

class AvatarAnimation extends StatefulWidget {
  final Duration duration; // Duration for each image in the animation

  AvatarAnimation({
    this.duration = const Duration(seconds: 1),
    Key? key,
  }) : super(key: key);

  @override
  _AvatarAnimationState createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation> {
  int _currentIndex = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        _currentIndex = (_currentIndex) % 10 + 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Image.asset(
        "assets/meme/$_currentIndex.png",
        key: ValueKey<int>(_currentIndex),
      ),
    );
  }
}
