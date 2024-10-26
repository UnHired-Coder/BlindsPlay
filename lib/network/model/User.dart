class User {
  final int id;
  final String userId;
  final String username;
  final String email;
  final String authType;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.email,
    required this.authType,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User object from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      authType: json['authType'],
      rating: json['rating'] ?? 1000,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
