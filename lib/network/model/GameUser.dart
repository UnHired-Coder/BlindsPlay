class GameUser {
  final int id;
  final String userId;
  final String username;
  final String email;
  final String avatar;
  final String authType;
  final int rating;
  final int rank;
  final DateTime createdAt;
  final DateTime updatedAt;

  GameUser({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.avatar,
    required this.authType,
    required this.rating,
    required this.rank,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User object from a JSON map.
  factory GameUser.fromJson(Map<String, dynamic> json) {
    return GameUser(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      authType: json['authType'],
      rating: (json['rating'] ?? 1000) as int,
      rank: (json['rank'] ?? -1) as int,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
