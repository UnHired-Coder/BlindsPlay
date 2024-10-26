import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/repository/login/FirebaseAuthService.dart';
import '../../../network/repository/login/UserRepository.dart';
import 'login_event.dart';
import 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;
  final UserRepository _userRepository;

  AuthBloc(
      {required FirebaseAuthService authService,
      required UserRepository userRepository})
      : _authService = authService,
        _userRepository = userRepository,
        super(AuthInitial()) {
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInAnonymously>(_onSignInAnonymously);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final User? firebaseUser = await _authService.signInWithGoogle();
      if (firebaseUser != null) {
        await _userRepository.loginUser(firebaseUser, 'google');
        emit(AuthAuthenticated(firebaseUser));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInAnonymously(
      SignInAnonymously event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final User? firebaseUser = await _authService.signInAnonymously();
      if (firebaseUser != null) {
        await _userRepository.loginUser(firebaseUser, 'anonymous');
        emit(AuthAuthenticated(firebaseUser));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
