import 'package:firebase_auth/firebase_auth.dart';

import 'UserService.dart';

class UserRepository {
  final UserService _userService;

  UserRepository({required UserService userService})
      : _userService = userService;

  Future<void> loginUser(User user, String authType) async {
    await _userService.loginUser(
      userId: user.uid,
      name: user.displayName ?? 'Anonymous',
      email: user.email ?? 'Anonymous@email.com',
      authType: authType,
    );
  }
}
