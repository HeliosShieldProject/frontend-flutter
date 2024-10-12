part of 'sign_in_bloc.dart';

sealed class SignInEvent {}

class SignInExecutedEvent extends SignInEvent {
  SignInExecutedEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
