// data/recent_game.dart
class RecentGame {
  final String opponentName;
  final int ratingBeforeGame;
  final int ratingChange;
  final bool win; // true if win, false if lose

  RecentGame({
    required this.opponentName,
    required this.ratingBeforeGame,
    required this.ratingChange,
    required this.win,
  });

  factory RecentGame.fromJson(Map<String, dynamic> json) {
    return RecentGame(
      opponentName: json['opponentName'],
      ratingBeforeGame: json['ratingBeforeGame'],
      ratingChange: json['ratingChange'],
      win: json['win'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'opponentName': opponentName,
      'ratingBeforeGame': ratingBeforeGame,
      'ratingChange': ratingChange,
      'win': win,
    };
  }
}
