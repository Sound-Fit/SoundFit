abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class AuthSuccess extends AuthState {
  final bool isAgeNull;

  AuthSuccess({required this.isAgeNull});
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}
