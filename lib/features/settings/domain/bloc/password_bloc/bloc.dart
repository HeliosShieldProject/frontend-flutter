import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/auth_repository/high_level/change_password.dart';
import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "event.dart";
part "state.dart";

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc({
    required this.userRepository,
  }) : super(const PasswordState.empty()) {
    on<PasswordChangeExecutedEvent>(_onPasswordChangeExecutedEvent);
  }

  final UserRepository userRepository;

  Future<void> _onPasswordChangeExecutedEvent(
      PasswordChangeExecutedEvent event, Emitter<PasswordState> emit) async {
    emit(state.copyWith(status: Auth.loading));

    final String newPassword = event.newPassword;

    try {
      final User refreshedUser = await refresh(userRepository.get());
      userRepository.put(user: refreshedUser);

      await changePassword(user: refreshedUser, newPassword: newPassword);

      emit(state.copyWith(status: Auth.success));
    } on Auth catch (e) {
      emit(state.copyWith(status: e));
    } catch (e) {
      emit(state.copyWith(status: Auth.failed));
    }
  }
}
