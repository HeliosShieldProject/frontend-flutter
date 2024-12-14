part of "bloc.dart";

class SignOutState extends Equatable {
  const SignOutState({
    required this.signOutStatus,
  });

  final Auth? signOutStatus;

  const SignOutState.empty() : signOutStatus = null;

  SignOutState copyWith({Auth? signOutStatus}) =>
      SignOutState(signOutStatus: signOutStatus ?? this.signOutStatus);

  @override
  List<Object?> get props => [signOutStatus];
}
