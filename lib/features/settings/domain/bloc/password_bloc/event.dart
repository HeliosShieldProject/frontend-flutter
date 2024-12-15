part of "bloc.dart";

sealed class PasswordEvent {}

class PasswordChangeExecutedEvent extends PasswordEvent {
  PasswordChangeExecutedEvent({required this.newPassword});

  final String newPassword;
}
