import 'InitialGameData.dart';
import 'User.dart';

class Player extends User {
  final String waitlistId;
  final InitialGameData initialGameData;

  Player({
    required int id,
    required String userId,
    required String username,
    required String email,
    required String authType,
    required int rating,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.waitlistId,
    required this.initialGameData,
  }) : super(
          id: id,
          userId: userId,
          username: username,
          email: email,
          authType: authType,
          rating: rating,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int,
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      authType: json['authType'] as String,
      rating: json['rating'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      waitlistId: json['WaitlistId'] as String,
      initialGameData: InitialGameData.fromJson(
        json['InitialGameData'] as Map<String, dynamic>,
      ),
    );
  }
}

typedef Opponent = Player;
