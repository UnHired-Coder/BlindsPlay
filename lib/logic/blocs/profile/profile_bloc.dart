// profile_bloc.dart
import 'dart:async';

import 'package:blindsplay/network/model/ProfileData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repository/login/UserRepository.dart';
import 'data/profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository; // API endpoint URL

  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
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
      ProfileData profileData = await userRepository.getUserProfile();

      final user = profileData.gameUser;
      return Profile(
        name: user.username,
        rating: user.rating,
        rank: user.rank,
        recentGames: profileData.gameHistory,
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
