// profile_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/profile.dart';
import 'data/recent_game.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final String apiUrl; // API URL

  ProfileBloc({required this.apiUrl}) : super(ProfileInitial()) {
    // Register the event handlers
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
  }

  // Event handler for LoadProfile event
  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _fetchProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile'));
    }
  }

  // Event handler for RefreshProfile event
  Future<void> _onRefreshProfile(RefreshProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _fetchProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(message: 'Failed to refresh profile'));
    }
  }

  Future<Profile> _fetchProfile() async {
    // Simulate a delay (API call)
    await Future.delayed(Duration(seconds: 2));

    // Mock profile data
    return Profile(
      name: 'John Doe',
      rating: 1500,
      rank: 5,
      recentGames: [
        RecentGame(opponentName: 'Alice', ratingBeforeGame: 1490, ratingChange: 10, win: true),
        RecentGame(opponentName: 'Bob', ratingBeforeGame: 1510, ratingChange: -10, win: false),
      ],
    );
  }

}
