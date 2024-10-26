// profile_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repository/login/UserRepository.dart';
import 'data/profile.dart';
import 'data/recent_game.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final String apiUrl; // API URL
  final UserRepository userRepository; // API endpoint URL

  ProfileBloc({required this.apiUrl, required this.userRepository})
      : super(ProfileInitial()) {
    // Register the event handlers
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
  }

  // Event handler for LoadProfile event
  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _fetchProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile'));
    }
  }

  // Event handler for RefreshProfile event
  Future<void> _onRefreshProfile(
      RefreshProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _fetchProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: 'Failed to refresh profile'));
    }
  }

  Future<Profile> _fetchProfile() async {
    // Mock profile data

    if (userRepository.isLoggedIn) {
      return Profile(
        name: userRepository.currentUser!.username,
        rating: userRepository.currentUser!.rating,
        rank: userRepository.currentUser!.rank,
        recentGames: [
          RecentGame(
              opponentName: 'Test User',
              ratingBeforeGame: 1000,
              ratingChange: 0,
              win: true),
        ],
      );
    } else {
      return Profile(
        name: '---',
        rating: 0,
        rank: 0,
        recentGames: [],
      );
    }
  }
}
