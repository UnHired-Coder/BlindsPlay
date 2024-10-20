enum EventType {
  playerMatched,
  joinedRoom,
  unknown,
}

EventType eventTypeFromString(String event) {
  switch (event) {
    case 'player-matched':
      return EventType.playerMatched;
    case 'joined-room':
      return EventType.joinedRoom;
    default:
      return EventType.unknown;
  }
}
