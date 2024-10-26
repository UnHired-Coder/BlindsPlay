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
  final LeaderboardEntry? userLeaderboard;
  final List<LeaderboardEntry> leaderboard;

  const LeaderboardLoaded(
      {required this.userLeaderboard, required this.leaderboard});

  // CopyWith to update the state easily
  LeaderboardLoaded copyWith(
      {LeaderboardEntry? userLeaderboard,
      List<LeaderboardEntry>? leaderboard}) {
    return LeaderboardLoaded(
        userLeaderboard: userLeaderboard ?? this.userLeaderboard,
        leaderboard: leaderboard ?? this.leaderboard);
  }
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);
}
