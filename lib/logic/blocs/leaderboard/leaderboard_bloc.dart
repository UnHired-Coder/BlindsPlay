import 'package:blindsplay/network/repository/common/CommonRepository.dart';
import 'package:blindsplay/network/repository/login/UserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/leader_board_entry.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final UserRepository userRepository; // API endpoint URL
  final CommonRepository commonRepository; // API endpoint URL

  LeaderboardBloc(
      {required this.userRepository, required this.commonRepository})
      : super(const LeaderboardInitial()) {
    // Register the event handlers
    on<StartLeaderboard>(_onStartLeaderboard);
    on<RefreshLeaderboard>(_onRefreshLeaderboard);
  }

  // Event handler for StartLeaderboard event
  Future<void> _onStartLeaderboard(
      StartLeaderboard event, Emitter<LeaderboardState> emit) async {
    emit(const LeaderboardLoading());

    try {
      // Fetch leaderboard from API
      List<LeaderboardEntry> leaderboard = await _fetchLeaderboard();
      emit(LeaderboardLoaded(
          userLeaderboard: (userRepository.isLoggedIn == true)
              ? LeaderboardEntry(
                  rank: userRepository.currentUser!.rank,
                  name: userRepository.currentUser!.username,
                  rating: userRepository.currentUser!.rating)
              : null,
          leaderboard: leaderboard));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }

  // Event handler for RefreshLeaderboard event
  Future<void> _onRefreshLeaderboard(
      RefreshLeaderboard event, Emitter<LeaderboardState> emit) async {
    if (state is LeaderboardLoaded) {
      final currentState = state as LeaderboardLoaded;

      try {
        // Fetch updated leaderboard from API
        List<LeaderboardEntry> updatedLeaderboard = await _fetchLeaderboard();
        emit(currentState.copyWith(leaderboard: updatedLeaderboard));
      } catch (e) {
        emit(const LeaderboardError('Failed to refresh leaderboard'));
      }
    }
  }

  // Helper function to fetch leaderboard data from API
  Future<List<LeaderboardEntry>> _fetchLeaderboard() async {
    final leaderboard = await commonRepository.getLeaderboard();
    return leaderboard
        .map((item) => LeaderboardEntry(
            rank: item.rank, name: item.username, rating: item.rating))
        .toList();
  }
}
