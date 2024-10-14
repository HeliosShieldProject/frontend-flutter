import 'package:Helios/repositories/local_repository/init.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/repositories/user_repository/user_repository.dart';

import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'event.dart';
part 'state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc({required this.userRepository})
      : super(const WelcomeState.empty()) {
    on<AppInitEvent>(onAppInit);
  }

  UserRepository userRepository;

  Future<void> onAppInit(AppInitEvent event, Emitter<WelcomeState> emit) async {
    emit(
      state.copyWith(
        appInitStatus: AppInitStatus.loading,
      ),
    );

    await initHive();
    await dotenv.load();

    final User user = userRepository.get();

    if (user.validity == UserValidity.notValid) {
      emit(
        state.copyWith(
          appInitStatus: AppInitStatus.userNotSufficient,
        ),
      );
    } else {
      await refresh(user).then(
        (value) {
          userRepository.put(
            user: value,
          );
          emit(
            state.copyWith(
              appInitStatus: AppInitStatus.success,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              appInitStatus: AppInitStatus.failed,
            ),
          );
        },
      );
    }
  }
}
