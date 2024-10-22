enum EventType {
  playerMatched,
  joinedRoom,
  makeMove,
  startGame,
  unknown,
}

EventType eventTypeFromString(String event) {
  switch (event) {
    case 'player-matched':
      return EventType.playerMatched;
    case 'joined-room':
      return EventType.joinedRoom;
    case 'make-move':
      return EventType.makeMove;
    case 'start-game':
      return EventType.startGame;
    default:
      return EventType.unknown;
  }
}
