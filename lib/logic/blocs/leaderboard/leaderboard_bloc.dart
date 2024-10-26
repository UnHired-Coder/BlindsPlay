import 'dart:convert';

import 'package:blindsplay/network/repository/login/UserRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/leader_board_entry.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final String apiUrl; // API endpoint URL
  final UserRepository userRepository; // API endpoint URL

  LeaderboardBloc({required this.apiUrl, required this.userRepository})
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
          userLeaderboard: LeaderboardEntry(
              rank: userRepository.currentUser!.rank,
              name: userRepository.currentUser!.username,
              rating: userRepository.currentUser!.rating),
          leaderboard: leaderboard));
    } catch (e) {
      emit(const LeaderboardError('Failed to load leaderboard'));
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
        emit(LeaderboardError('Failed to refresh leaderboard'));
      }
    }
  }

  // Helper function to fetch leaderboard data from API
  Future<List<LeaderboardEntry>> _fetchLeaderboard() async {
    http.Response response;

    // Simulate a delay (e.g., network call)
    await Future.delayed(const Duration(seconds: 1));

    // Mock leaderboard data
    final leaderboardData = [
      {
        "rank": 1,
        "name": "Alice",
        "rating": 1500,
      },
      {
        "rank": 2,
        "name": "Bob",
        "rating": 1450,
      },
      {
        "rank": 3,
        "name": "Charlie",
        "rating": 1400,
      },
      {
        "rank": 4,
        "name": "Diana",
        "rating": 1350,
      },
      {
        "rank": 5,
        "name": "Eve",
        "rating": 1300,
      },
    ];

    // Convert the mock data to a JSON string
    String jsonString = jsonEncode({"leaderboard": leaderboardData});
    // Simulate a successful API response
    response = http.Response(jsonString, 200);

    // Handle the response
    if (response.statusCode == 200) {
      // Parse the response body
      Map<String, dynamic> decodedResponse = json.decode(response.body);
      List<dynamic> data = decodedResponse["leaderboard"];

      // Convert parsed data into a list of LeaderboardEntry objects
      return data.map((entry) => LeaderboardEntry.fromJson(entry)).toList();
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }
}
