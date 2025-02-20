part of 'login_form_bloc.dart';

enum FormStatus { invalid, valid, posting }

class LoginFormState extends Equatable {
  final bool isValid;
  final bool isPosting;
  final Username username;
  final Password password;

  const LoginFormState({
    this.isValid = false,
    this.isPosting = false,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });
  LoginFormState copyWith({
    bool? isValid,
    bool? isPosting,
    Username? username,
    Password? password,
  }) =>
      LoginFormState(
        isValid: isValid ?? this.isValid,
        isPosting: isPosting ?? this.isPosting,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [isValid, isPosting, username, password];
}
