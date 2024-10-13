part of 'sign_in_bloc.dart';

@immutable
class SignInState extends Equatable {
  const SignInState({
    required this.signInStatus,
  });

  final Auth? signInStatus;

  const SignInState.empty() : signInStatus = null;

  SignInState copyWith({Auth? signInStatus}) => SignInState(
        signInStatus: signInStatus ?? this.signInStatus,
      );

  @override
  List<Object?> get props => [
        signInStatus,
      ];
}
