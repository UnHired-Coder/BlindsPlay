import 'dart:math';

import 'package:blindsplay/network/model/GameUser.dart';
import 'package:blindsplay/network/model/ProfileData.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UserService.dart';

class UserRepository {
  final UserService _userService;
  GameUser? _currentUser;

  UserRepository({required UserService userService})
      : _userService = userService;

  GameUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<void> loginUser(User firebaseUser, String authType) async {
    final randomName = (firebaseUser.displayName?.isNotEmpty == true)
        ? firebaseUser.displayName.toString()
        : generateRandomGuestName();

    final email = (firebaseUser.email?.isNotEmpty == true)
        ? firebaseUser.email.toString()
        : "Anonymous@email.com";

    _currentUser = await _userService.loginUser(
      userId: firebaseUser.uid,
      name: randomName,
      email: email,
      authType: authType,
    );
  }

  Future<ProfileData> getUserProfile() async {
    final userProfile =
        await _userService.getUserProfile(userId: _currentUser!.userId);
    _currentUser = userProfile.gameUser;
    return userProfile!;
  }

  // Helper function to generate a random guest name
  String generateRandomGuestName() {
    const length = 4;
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    final randomString =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();
    return 'Guest-$randomString';
  }
}
