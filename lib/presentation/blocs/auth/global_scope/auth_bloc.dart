import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/domain/repositories/auth_repository.dart';
import 'package:qr_scanner_app/domain/repositories/key_value_storage_repository.dart';
import 'package:qr_scanner_app/infrastructure/errors/auth_errors.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageRepository keyValueStorageRepository;

  final ValueNotifier<AuthState> authStateNotifier =
      ValueNotifier(const AuthState());

  AuthBloc(
      {required this.authRepository, required this.keyValueStorageRepository})
      : super(const AuthState()) {
    on<CheckAuthStatus>(_checkAuthStatus);
    on<LoginUser>(_loginUser);

    on<Logout>((Logout event, Emitter<AuthState> emit) async {
      await authRepository.logout();

      emit(state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: event.errorMessage));
      authStateNotifier.value = state.copyWith(
          authStatus: AuthStatus.notAuthenticated,
          user: null,
          errorMessage: event.errorMessage);
    });

    stream.listen((state) {
      authStateNotifier.value = state;
    });
  }

  void _loginUser(LoginUser event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.login(event.username);

      _setLoggedUser(emit, user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout();
    }
  }

  void _checkAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.checkAuthStatus();

      if (user != null) {
        _setLoggedUser(emit, user);
        return;
      }

      logout('No tiene cuenta registrada');
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void _setLoggedUser(Emitter<AuthState> emit, User user) {
    emit(state.copyWith(authStatus: AuthStatus.authenticated, user: user));
    authStateNotifier.value =
        state.copyWith(authStatus: AuthStatus.authenticated, user: user);
  }

  void authenticateUser(String username, String password) {
    add(LoginUser(username, password));
  }

  void logout([String? errorMessage]) {
    add(Logout(errorMessage));
  }

  @override
  Future<void> close() {
    authStateNotifier.dispose();
    return super.close();
  }
}
