import 'dart:async';

import '../WebService.dart';
import '../WebSocketService.dart';
import '../model/MatchingStartedData.dart';
import 'IGameRepository.dart';

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
  Future<void> joinRoom(
      int playerID, String roomID, MessageCallback onConnected) async {
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
  Future<void> makeMove(int playerID, String roomID, int posX, int posY) async {
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
  Future<MatchingStartedData> findMatch(int userId) async {
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
      int playerID, String waitlistId, MessageCallback onConnected) async {
    final url =
        "ws://10.0.2.2:8080/tictacmemo/find-match/$playerID/$waitlistId";
    _webSocketService.connect(url, onConnected = onConnected);
  }
}
