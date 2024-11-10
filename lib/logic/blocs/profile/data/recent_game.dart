class RecentGame {
  final int id;
  final String userId;
  final String opponentUserId;
  final String opponentUsername;
  final int ratingChange;
  final int ratingBeforeChange;
  final DateTime createdAt;

  RecentGame({
    required this.id,
    required this.userId,
    required this.opponentUserId,
    required this.opponentUsername,
    required this.ratingChange,
    required this.ratingBeforeChange,
    required this.createdAt,
  });

  // Factory method to create an instance from JSON
  factory RecentGame.fromJson(Map<String, dynamic> json) {
    return RecentGame(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      opponentUserId: json['opponent_user_id'] as String,
      opponentUsername: json['username'] as String,
      ratingChange: json['rating_change'] as int,
      ratingBeforeChange: json['rating_before_change'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
