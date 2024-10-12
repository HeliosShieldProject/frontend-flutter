import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/repositories/auth_repository/high_level/sign_up.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';

part 'event.dart';
part 'state.dart';

class SignInBloc extends Bloc<SignInEvent, SignUpState> {
  SignInBloc({required this.userRepository})
      : super(const SignUpState.unknwon()) {
    on<SignUpExecutedEvent>(onSignUpExecuted);
  }

  UserRepository userRepository;

  void onSignUpExecuted(SignUpExecutedEvent event, Emitter<SignUpState> emit) {
    final String email = event.email;
    final String password = event.password;

    signUp(email: email, password: password).then(
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
