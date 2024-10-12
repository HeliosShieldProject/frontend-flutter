part of 'sign_in_bloc.dart';

@immutable
class SignInState extends Equatable {
  const SignInState({
    required this.signInStatus,
  });

  final Auth? signInStatus;

  const SignInState.unknwon() : signInStatus = null;

  SignInState copyWith({Auth? signInStatus}) => SignInState(
        signInStatus: signInStatus ?? this.signInStatus,
      );

  @override
  List<Object?> get props => [
        signInStatus,
      ];
}
