part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class LoginUser extends AuthEvent {
  final String username;
  final String password;
  const LoginUser(this.username, this.password);
}

class BiometricLoginUser extends AuthEvent {
  const BiometricLoginUser();
}

class Logout extends AuthEvent {
  final String? errorMessage;
  const Logout(this.errorMessage);
}
