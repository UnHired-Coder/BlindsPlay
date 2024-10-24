import 'BaseResponse.dart';
import 'Events.dart';

class InitialGameData {
  final String assignedLabel;

  InitialGameData({required this.assignedLabel});

  factory InitialGameData.fromJson(Map<String, dynamic> json) {
    try {
      return InitialGameData(
        assignedLabel: json['AssignedLable'] as String,
      );
    } catch (e) {
      throw Exception('Failed to parse InitialGameData: $e');
    }
  }
}

class BoardGameState {
  final List<List<String>> board;
  final List<List<String>> visibleBoard;
  final String currentPlayer;
  final String winner;
  final bool isDraw;

  BoardGameState({
    required this.board,
    required this.visibleBoard,
    required this.currentPlayer,
    required this.winner,
    required this.isDraw,
  });

  factory BoardGameState.fromJson(Map<String, dynamic> json) {
    try {
      return BoardGameState(
        board: (json['board'] as List<dynamic>)
            .map((row) => List<String>.from(row))
            .toList(),
        visibleBoard: (json['visible_board'] as List<dynamic>)
            .map((row) => List<String>.from(row))
            .toList(),
        currentPlayer: json['current_player'] as String,
        winner: json['winner'] as String,
        isDraw: json['is_draw'] as bool,
      );
    } catch (e) {
      throw Exception('Failed to parse BoardGameState: $e');
    }
  }
}

class Room {
  final String roomId;
  final List<dynamic> players;
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
        players: json['players'] as List<dynamic>,
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

class PlayerMatchedData {
  final InitialGameData initialGameData;
  final Room room;
  final String roomId;

  PlayerMatchedData({
    required this.initialGameData,
    required this.room,
    required this.roomId,
  });

  factory PlayerMatchedData.fromJson(Map<String, dynamic> json) {
    try {
      final initialGameData = InitialGameData.fromJson(
        json['InitialGameData'] as Map<String, dynamic>,
      );

      final room = Room.fromJson(json['room'] as Map<String, dynamic>);

      final roomId = json['room_id'] as String;

      return PlayerMatchedData(
        initialGameData: initialGameData,
        room: room,
        roomId: roomId,
      );
    } catch (e) {
      throw Exception('Failed to parse PlayerMatchedData: $e');
    }
  }
}

class PlayerMatchedResponse extends BaseResponse {
  final PlayerMatchedData data;

  PlayerMatchedResponse({
    required EventType eventType,
    required this.data,
  }) : super(eventType: eventType, data: data);
}
