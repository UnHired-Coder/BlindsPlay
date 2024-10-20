import 'BaseResponse.dart';
import 'Events.dart';

class JoinedRoomData {
  final String roomId;
  final int playerId;

  JoinedRoomData({required this.roomId, required this.playerId});

  factory JoinedRoomData.fromJson(Map<String, dynamic> json) {
    return JoinedRoomData(
      roomId: json['room_id'] as String,
      playerId: json['player_id'] as int,
    );
  }
}

class JoinedRoomResponse extends BaseResponse {
  final JoinedRoomData data;

  JoinedRoomResponse({
    required EventType eventType,
    required this.data,
  }) : super(eventType: eventType, data: data);
}
