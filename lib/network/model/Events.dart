enum EventType {
  playerMatched,
  joinedRoom,
  makeMove,
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
    default:
      return EventType.unknown;
  }
}
