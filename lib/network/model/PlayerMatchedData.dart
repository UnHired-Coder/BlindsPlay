import 'BaseResponse.dart';
import 'Events.dart';
import 'Player.dart';

class PlayerMatchedData {
  final Opponent opponent;
  final String roomId;
  final GamePlayer you;

  PlayerMatchedData({
    required this.opponent,
    required this.roomId,
    required this.you,
  });

  factory PlayerMatchedData.fromJson(Map<String, dynamic> json) {
    return PlayerMatchedData(
      opponent: Opponent.fromJson(json['opponenet'] as Map<String, dynamic>),
      roomId: json['room_id'] as String,
      you: GamePlayer.fromJson(json['you'] as Map<String, dynamic>),
    );
  }
}

class PlayerMatchedResponse extends BaseResponse {
  final PlayerMatchedData data;

  PlayerMatchedResponse({
    required EventType eventType,
    required this.data,
  }) : super(eventType: eventType, data: data);
}
