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
