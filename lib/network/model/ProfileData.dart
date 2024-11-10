import 'package:blindsplay/logic/blocs/profile/data/recent_game.dart';

import 'GameUser.dart';

class ProfileData {
  final GameUser gameUser;
  final List<RecentGame> gameHistory;

  ProfileData({required this.gameUser, required this.gameHistory});

  // Factory method to create a User object from a JSON map.
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      gameUser: GameUser.fromJson(json['user']),
      gameHistory: (json['game_history'] as List)
          .map((item) => RecentGame.fromJson(item))
          .toList(),
    );
  }
}
