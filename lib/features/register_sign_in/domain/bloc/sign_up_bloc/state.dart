part of 'sign_up_bloc.dart';

@immutable
class SignUpState extends Equatable {
  const SignUpState({
    required this.signInStatus,
  });

  final Auth? signInStatus;

  const SignUpState.unknwon() : signInStatus = null;

  SignUpState copyWith({Auth? signInStatus}) => SignUpState(
        signInStatus: signInStatus ?? this.signInStatus,
      );

  @override
  List<Object?> get props => [
        signInStatus,
      ];
}
