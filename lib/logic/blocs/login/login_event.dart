abstract class AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class SignInAnonymously extends AuthEvent {}

class SignOut extends AuthEvent {}
