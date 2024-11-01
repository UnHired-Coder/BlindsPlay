import '../../model/MatchingStartedData.dart';
import 'WebSocketService.dart';

abstract class IGameRepository {
  Future<void> joinRoom(String playerID, String roomID);
  Future<void> makeMove(String playerID, String roomID, int posX, int posY);
  Future<void> updateScore(String playerID, String roomID,
      String? assignedLabel, int elapsedTime, int moveCount);

  Future<MatchingStartedData> findMatch(String userId); // New method
  Future<void> match(
      String playerID, String waitlistId, MessageCallback onConnected);
  Future<void> playGame(String roomID, MessageCallback onConnected);
  // Method to be called when the WebSocket connection is established
  void close();
}
