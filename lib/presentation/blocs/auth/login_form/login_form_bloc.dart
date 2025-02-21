import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:qr_scanner_app/infrastructure/inputs/password.dart';
import 'package:qr_scanner_app/infrastructure/inputs/username.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormBloc({required this.loginUserCallback})
      : super(const LoginFormState()) {
    on<LoginUsernameChanged>(
        (LoginUsernameChanged event, Emitter<LoginFormState> emit) {
      final newUsername = Username.dirty(event.username);
      emit(state.copyWith(
          isValid: Formz.validate([newUsername, state.password]),
          username: newUsername));
    });
    on<LoginPasswordChanged>(
        (LoginPasswordChanged event, Emitter<LoginFormState> emit) {
      final newPassword = Password.dirty(event.password);
      emit(state.copyWith(
          isValid: Formz.validate([newPassword, state.username]),
          password: newPassword));
    });

    on<TouchEveryField>(
      (event, emit) {
        final username = Username.dirty(state.username.value);
        final password = Password.dirty(state.password.value);

        emit(state.copyWith(
            isPosting: true,
            username: username,
            password: password,
            isValid: Formz.validate([username, password])));
      },
    );
  }

  void loginUsernameChanged(String username) {
    add(LoginUsernameChanged(username));
  }

  void loginPasswordChanged(String password) {
    add(LoginPasswordChanged(password));
  }

  void onSubmit() async {
    add(const TouchEveryField());
    if (!state.isValid) return;

    // show loading

    await loginUserCallback(state.username.value, state.password.value);

    // hide loading
  }
}
