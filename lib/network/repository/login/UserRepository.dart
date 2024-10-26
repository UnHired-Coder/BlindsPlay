import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

import 'UserService.dart';

class UserRepository {
  final UserService _userService;

  UserRepository({required UserService userService})
      : _userService = userService;

  Future<void> loginUser(User user, String authType) async {
    final String randomName = user.displayName ?? generateRandomGuestName();

    await _userService.loginUser(
      userId: user.uid,
      name: randomName,
      email: user.email ?? 'Anonymous@email.com',
      authType: authType,
    );
  }

// Helper function to generate a random guest name
  String generateRandomGuestName() {
    const length = 4;
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    // Generate a random string of length `length`
    final randomString =
        List.generate(length, (index) => chars[random.nextInt(chars.length)])
            .join();

    return 'Guest-$randomString';
  }
}
