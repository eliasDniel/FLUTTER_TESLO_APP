import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/auth/domain/domain.dart';
import 'package:flutter_teslo_app/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository
  }) : super(AuthState());

  void loginUser(String email, String password) async {}
  void registerUser(String email, String password, String fullname) async {}
  void checkAuthStatus() async {}
}

enum AuthStatus { authenticated, unauthenticated, checking }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
