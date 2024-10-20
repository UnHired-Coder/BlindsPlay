import 'BaseResponse.dart';
import 'Events.dart';

class MatchingStartedData {
  final String waitlistId;

  MatchingStartedData({required this.waitlistId});

  factory MatchingStartedData.fromJson(Map<String, dynamic> json) {
    return MatchingStartedData(
      waitlistId: json['waitlist_id'] as String,
    );
  }
}

class MatchingStartedResponse extends BaseResponse {
  final MatchingStartedData data;

  MatchingStartedResponse({
    required EventType eventType,
    required this.data,
  }) : super(eventType: eventType, data: data);
}
