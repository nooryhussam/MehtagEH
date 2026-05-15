enum UserRole { donor, requester, admin }

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  final UserRole role;
  final String? userName;
  AuthSuccess({required this.token, required this.role, this.userName});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}
