import 'dart:convert';

import 'package:blindsplay/network/model/JoinedRoomData.dart';

import 'BoardState.dart';
import 'Events.dart';
import 'PlayerMatchedData.dart';

class BaseResponse {
  final EventType eventType;
  final dynamic data;

  BaseResponse({required this.eventType, required this.data});

  // Factory method to create a BaseResponse from JSON
  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    final event = json['event'] as String;
    final eventType = eventTypeFromString(event);

    return BaseResponse(
      eventType: eventType,
      data: json['data'],
    );
  }

  // Method to parse the response into specific event data
  static BaseResponse parseResponse(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    final baseResponse = BaseResponse.fromJson(json);

    late final dynamic data;

    switch (baseResponse.eventType) {
      case EventType.playerMatched:
        data = PlayerMatchedData.fromJson(baseResponse.data);
        break;
      case EventType.joinedRoom:
        data = JoinedRoomData.fromJson(baseResponse.data);
        break;
      case EventType.startGame:
        data = BoardGameState.fromJson(baseResponse.data);
        break;
      case EventType.makeMove:
        data = BoardGameState.fromJson(baseResponse.data);
      default:
        data = null;
        break;
    }
    return BaseResponse(eventType: baseResponse.eventType, data: data);
  }
}
