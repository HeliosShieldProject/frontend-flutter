part of 'sign_up_bloc.dart';

sealed class SignInEvent {}

class SignUpExecutedEvent extends SignInEvent {
  SignUpExecutedEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
