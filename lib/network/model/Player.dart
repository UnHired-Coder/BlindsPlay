import 'GameUser.dart';
import 'InitialGameData.dart';

class GamePlayer extends GameUser {
  final String waitlistId;
  final InitialGameData initialGameData;

  GamePlayer(
      {required int id,
      required String userId,
      required String username,
      required String email,
      required String avatar,
      required String authType,
      required int rating,
      required int rank,
      required DateTime createdAt,
      required DateTime updatedAt,
      required this.waitlistId,
      required this.initialGameData})
      : super(
          id: id,
          userId: userId,
          username: username,
          email: email,
          avatar: avatar,
          authType: authType,
          rating: rating,
          rank: rank,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory GamePlayer.fromJson(Map<String, dynamic> json) {
    return GamePlayer(
      id: json['id'] as int,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      authType: json['authType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      waitlistId: json['WaitlistId'] as String,
      rating: (json['rating'] ?? 1000) as int,
      rank: (json['rank'] ?? 0) as int,
      initialGameData: InitialGameData.fromJson(
        json['InitialGameData'] as Map<String, dynamic>,
      ),
    );
  }
}

typedef Opponent = GamePlayer;
