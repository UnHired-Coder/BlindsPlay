// Example model class for the "matching-started" event
class MatchingStartedData {
  final String waitlistId;

  MatchingStartedData({required this.waitlistId});

  factory MatchingStartedData.fromJson(Map<String, dynamic> json) {
    return MatchingStartedData(
      waitlistId: json['waitlist_id'] as String,
    );
  }
}
