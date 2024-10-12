import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/repositories/auth_repository/high_level/sign_in.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.userRepository})
      : super(const SignInState.unknwon()) {
    on<SignInExecutedEvent>(onSignInExecuted);
  }

  UserRepository userRepository;

  void onSignInExecuted(SignInExecutedEvent event, Emitter<SignInState> emit) {
    final String email = event.email;
    final String password = event.password;

    signIn(email: email, password: password).then(
      (value) {
        userRepository.put(user: value);
        emit(
          state.copyWith(
            signInStatus: Auth.success,
          ),
        );
      },
      onError: (error) {
        if (error is Auth) {
          emit(
            state.copyWith(
              signInStatus: error,
            ),
          );
        } else {
          emit(
            state.copyWith(
              signInStatus: Auth.failed,
            ),
          );
        }
      },
    );
  }
}
