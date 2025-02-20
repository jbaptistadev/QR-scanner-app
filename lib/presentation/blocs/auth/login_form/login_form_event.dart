part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginFormEvent {
  final String username;
  const LoginUsernameChanged(this.username);
}

class LoginPasswordChanged extends LoginFormEvent {
  final String password;
  const LoginPasswordChanged(this.password);
}

class TouchEveryField extends LoginFormEvent {
  const TouchEveryField();
}

class OnSubmit extends LoginFormEvent {
  final String username;
  final String password;
  const OnSubmit(this.username, this.password);
}
