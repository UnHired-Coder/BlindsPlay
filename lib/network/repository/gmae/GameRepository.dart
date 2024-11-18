import 'dart:async';

import 'package:blindsplay/config/constants.dart';

import '../../model/MatchingStartedData.dart';
import 'IGameRepository.dart';
import 'WebService.dart';
import 'WebSocketService.dart';

class GameRepository implements IGameRepository {
  final WebSocketService _webSocketService;
  final WebService _webService;

  final StreamController<Map<String, dynamic>> _socketStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  StreamSubscription<dynamic>? _webSocketSubscription;

  GameRepository(
      {required WebSocketService webSocketService,
      required WebService webService})
      : _webSocketService = webSocketService,
        _webService = webService;

  @override
  Future<void> joinRoom(String playerID, String roomID) async {
    final joinMessage = {
      "action": "join-room",
      "data": {
        "playerID": playerID,
        "roomID": roomID,
      }
    };
    _webSocketService.sendMessage(joinMessage);
  }

  @override
  Future<void> makeMove(
      String playerID, String roomID, int posX, int posY) async {
    final moveMessage = {
      "action": "make-move",
      "data": {
        "playerID": playerID,
        "roomID": roomID,
        "posX": posX,
        "posY": posY,
      }
    };
    _webSocketService.sendMessage(moveMessage);
  }

  @override
  Future<void> updateScore(String playerID, String roomID,
      String? assignedLabel, int elapsedTime, int moveCount) async {
    final updateScoreMessage = {
      "action": "update-score",
      "data": {
        "playerID": playerID,
        "roomID": roomID,
        "assignedLabel": assignedLabel,
        "elapsedTime": elapsedTime,
        "moveCount": moveCount
      }
    };
    _webSocketService.sendMessage(updateScoreMessage);
  }

  @override
  Future<MatchingStartedData> findMatch(String userId) async {
    return _webService.findMatch(userId);
  }

  @override
  void close() {
    _webSocketSubscription?.cancel();
    _webSocketService.close();
    _socketStreamController.close();
  }

  @override
  Future<void> match(
      String playerID, String waitlistId, MessageCallback onConnected) async {
    final url =
        "${AppConstants.BASE_WS_URL}/tictacmemo/find-match/$playerID/$waitlistId";
    _webSocketService.connect(url, onConnected = onConnected);
  }

  @override
  Future<void> playGame(String roomID, MessageCallback onConnected) async {
    final url = "${AppConstants.BASE_WS_URL}/tictacmemo/play-game/$roomID";
    _webSocketService.connect(url, onConnected = onConnected);
  }
}
