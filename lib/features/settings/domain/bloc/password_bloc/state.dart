part of "bloc.dart";

@immutable
class PasswordState extends Equatable {
  const PasswordState({required this.status});

  final Auth? status;

  const PasswordState.empty() : status = null;

  PasswordState copyWith({Auth? status}) =>
      PasswordState(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
