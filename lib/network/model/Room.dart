import 'BoardState.dart';
import 'GameUser.dart';

class Room {
  final String roomId;
  final List<GameUser> players;
  final int maxPlayers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BoardGameState boardGameState;
  final String currentTurn;
  final Map<String, String> playerIds;

  Room({
    required this.roomId,
    required this.players,
    required this.maxPlayers,
    required this.createdAt,
    required this.updatedAt,
    required this.boardGameState,
    required this.currentTurn,
    required this.playerIds,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    try {
      return Room(
        roomId: json['room_id'] as String,
        players: (json['players'] as List<dynamic>)
            .map((playerJson) =>
                GameUser.fromJson(playerJson as Map<String, dynamic>))
            .toList(),
        maxPlayers: json['maxPlayers'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        boardGameState: BoardGameState.fromJson(json['GameState']),
        currentTurn: json['CurrentTurn'] as String,
        playerIds:
            Map<String, String>.from(json['PlayerIDs'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw Exception('Failed to parse Room: $e');
    }
  }
}
