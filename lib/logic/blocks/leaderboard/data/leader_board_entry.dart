class LeaderboardEntry {
  final int rank;
  final String name;
  final int rating;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.rating,
  });

  // Factory method to create a LeaderboardEntry from JSON
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'],
      name: json['name'],
      rating: json['rating'],
    );
  }
}
