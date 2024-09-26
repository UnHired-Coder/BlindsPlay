// data/profile.dart
class Profile {
  final String name;
  final int rating;
  final int rank;

  Profile({
    required this.name,
    required this.rating,
    required this.rank,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      rating: json['rating'],
      rank: json['rank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'rank': rank,
    };
  }
}
