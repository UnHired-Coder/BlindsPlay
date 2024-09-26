// Leaderboard States
import 'data/leader_board_entry.dart';

abstract class LeaderboardState {
  const LeaderboardState();
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> leaderboard;

  const LeaderboardLoaded({required this.leaderboard});

  // CopyWith to update the state easily
  LeaderboardLoaded copyWith({List<LeaderboardEntry>? leaderboard}) {
    return LeaderboardLoaded(leaderboard: leaderboard ?? this.leaderboard);
  }
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);
}