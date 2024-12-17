import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundfit/data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.loginUser(event.email, event.password);
      if (user != null) {
        final userData = await _authRepository.getUserData(user.uid);
        bool isAgeNull = userData?['age'] == null;
        emit(AuthSuccess(isAgeNull: isAgeNull));
      } else {
        emit(AuthFailure(errorMessage: "User not found"));
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.registerUser(
        event.username,
        event.email,
        event.password,
      );
      if (user != null) {
        emit(RegisterSuccess());
      } else {
        emit(AuthFailure(errorMessage: "Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
