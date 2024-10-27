import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Cubit<int> {
  Timer? _timer;
  bool isPaused = false;

  TimerBloc() : super(0);

  void startCountdown(Duration duration) {
    _timer?.cancel();
    emit(0);
    int secondsPassed = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        secondsPassed++;
        emit(secondsPassed);
        if (secondsPassed >= duration.inSeconds) {
          timer.cancel();
        }
      }
    });
  }

  void pause(bool pause) {
    isPaused = pause;
  }

  void reset() {
    _timer?.cancel();
    emit(0);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
