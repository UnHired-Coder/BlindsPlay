// data/profile.dart
import 'package:blindsplay/logic/blocs/profile/data/recent_game.dart';

class Profile {
  final String name;
  final int rating;
  final int rank;
  final List<RecentGame> recentGames; // List of recent games

  Profile({
    required this.name,
    required this.rating,
    required this.rank,
    required this.recentGames,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    var recentGamesJson = json['recentGames'] as List;
    List<RecentGame> recentGamesList = recentGamesJson.map((game) => RecentGame.fromJson(game)).toList();

    return Profile(
      name: json['name'],
      rating: json['rating'],
      rank: json['rank'],
      recentGames: recentGamesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'rank': rank,
      'recentGames': recentGames.map((game) => game.toJson()).toList(),
    };
  }
}
