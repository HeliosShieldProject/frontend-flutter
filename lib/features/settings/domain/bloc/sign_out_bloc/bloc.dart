import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';

import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:Helios/repositories/auth_repository/high_level/sign_out.dart';

import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';
import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';

part "event.dart";
part "state.dart";

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutBloc({
    required this.vpnConnectionRepository,
    required this.userRepository,
    required this.userSettingsRepository,
  }) : super(const SignOutState.empty()) {
    on<SignOutExecutedEvent>(_onSignOutExecutedEvent);
  }

  final VpnConnectionRepository vpnConnectionRepository;
  final UserRepository userRepository;
  final UserSettingsRepository userSettingsRepository;

  Future<void> _onSignOutExecutedEvent(
      SignOutExecutedEvent event, Emitter<SignOutState> emit) async {
    emit(state.copyWith(signOutStatus: Auth.loading));

    final States currentVpnConnectionState =
        vpnConnectionRepository.get().state;

    if (currentVpnConnectionState == States.disconnected) {
      try {
        final User refreshedUser = await refresh(userRepository.get());
        userRepository.put(user: refreshedUser);

        await signOut(user: userRepository.get());

        await vpnConnectionRepository.delete();
        await userRepository.delete();
        await userSettingsRepository.delete();

        emit(state.copyWith(signOutStatus: Auth.success));
      } on Auth catch (e) {
        emit(state.copyWith(signOutStatus: e));
      } catch (e) {
        emit(state.copyWith(signOutStatus: Auth.failed));
      }
    } else {
      emit(state.copyWith(signOutStatus: Auth.failed));
    }
  }
}
