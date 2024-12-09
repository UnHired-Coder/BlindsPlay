class AppConstants {
  static const int boardSize = 3;
  static const double cellWidth = 100.0;
  static const double boardWidth = boardSize * cellWidth;

  static const int delayToHide = 500;
  static const int waitingToStartTime = 5;
  static const int refreshPlaceholdersDuration = 3;

  static const String fontFamily1 = "FiraSans";

  // static const String BASE_URL = "http://10.0.2.2:8080";
  // static const String BASE_WS_URL = "ws://10.0.2.2:8080";
  //
  // static const String BASE_URL = "http://0.0.0.0:8080";
  // static const String BASE_WS_URL = "ws://0.0.0.0:8080";

  //prod
  static const String BASE_URL = "https://tictacmemo-server.vercel.app";
  static const String BASE_WS_URL = "wss://tictacmemo-server.vercel.app";
}
