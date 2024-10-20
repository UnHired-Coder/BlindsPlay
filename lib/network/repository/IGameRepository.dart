import '../WebSocketService.dart';
import '../model/GameResponse.dart';

abstract class IGameRepository {
  Future<void> joinRoom(
      int playerID, String roomID, MessageCallback onConnected);
  Future<void> makeMove(int playerID, String roomID, int posX, int posY);
  Future<MatchingStartedData> findMatch(int userId); // New method
  Future<void> match(
      int playerID, String waitlistId, MessageCallback onConnected);
  // Method to be called when the WebSocket connection is established
  void close();
}
