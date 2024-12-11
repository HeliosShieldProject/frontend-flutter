import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/ip.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';
import 'package:Helios/repositories/session_repository/high_level/close_session.dart';
import 'package:Helios/repositories/session_repository/high_level/create_session.dart';
import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:hive/hive.dart';

part 'event.dart';
part 'state.dart';

part 'generated/vpn_bloc.g.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  VpnBloc({
    required UserRepository userRepository,
    required VpnConnectionRepository vpnConnectionRepository,
  })  : _userRepository = userRepository,
        _vpnConnectionRepository = vpnConnectionRepository,
        super(VpnState.empty) {
    on<VpnAppInitEvent>(_onVpnAppInit);
    on<VpnStatusChangedEvent>(_onVpnStatusChanged);
    on<VpnConnectionExecutedEvent>(_onVpnConnectionExecuted);
    on<VpnConnectionDisconnectedEvent>(_onVpnConnectionDisconnected);
    on<ChangeSelectedServerEvent>(_onChangeSelectedServer);
  }

  late final FlutterV2ray _flutterV2ray;

  final UserRepository _userRepository;
  final VpnConnectionRepository _vpnConnectionRepository;

  bool _blockConnectedV2rayStatus = false;

  Future<void> _onVpnAppInit(
      VpnAppInitEvent event, Emitter<VpnState> emit) async {
    _flutterV2ray = FlutterV2ray(
      onStatusChanged: (status) {
        add(VpnStatusChangedEvent(status: status));
      },
    );

    emit(state.copyWith(state: States.loading));

    try {
      await _flutterV2ray.initializeV2Ray();

      final VpnConnection localConnection = _vpnConnectionRepository.get();

      final States v2rayState = await _flutterV2ray.state;
      final States localState = localConnection.state;

      if ((v2rayState == States.disconnected || v2rayState == States.error) &&
          localState == States.connected) {
        await _refreshUser();

        await closeSession(user: _userRepository.get());

        _vpnConnectionRepository.reset();
      }

      emit(state.copyWith(
        state: v2rayState,
        country: localConnection.country,
        protocol: localConnection.protocol,
        ip: localConnection.ip,
      ));
    } on Auth catch (e) {
      emit(VpnState.authError(error: e, thrownBy: event));
    } catch (e) {
      emit(VpnState.error(error: "Init error", thrownBy: event));
    }
  }

  Future<void> _onVpnStatusChanged(
      VpnStatusChangedEvent event, Emitter<VpnState> emit) async {
    final VpnConnection localConnection = _vpnConnectionRepository.get();

    final V2RayStatus v2rayStatus = event.status;

    switch ((v2rayStatus.status, localConnection.state)) {
      case (States.error, _):
        emit(VpnState.error(error: 'V2ray error', thrownBy: event));

        if (localConnection.state == States.connected) {
          try {
            await _refreshUser();

            await closeSession(user: _userRepository.get());

            _vpnConnectionRepository.reset();

            await _flutterV2ray.stopV2Ray();
          } on Auth catch (e) {
            emit(VpnState.authError(error: e, thrownBy: event));
          } catch (e) {
            emit(VpnState.error(error: 'Disconnect error', thrownBy: event));
          }
        }

        break;
      case (States.disconnected, States.connected):
        try {
          await _refreshUser();

          await closeSession(user: _userRepository.get());

          _vpnConnectionRepository.reset();

          add(VpnStatusChangedEvent(status: v2rayStatus));
        } on Auth catch (e) {
          emit(VpnState.authError(error: e, thrownBy: event));
        } catch (e) {
          emit(VpnState.error(error: 'Close session error', thrownBy: event));
        }

        break;
      case (States.disconnected, States.disconnected):
        emit(state.copyWith(state: States.disconnected));

        break;
      default:
        if (!_blockConnectedV2rayStatus) {
          final double uploadSpeed = num.parse(
                  (v2rayStatus.uploadSpeed.toDouble() / pow(2, 20))
                      .toStringAsFixed(2))
              .toDouble();
          final double downloadSpeed = num.parse(
                  (v2rayStatus.downloadSpeed.toDouble() / pow(2, 20))
                      .toStringAsFixed(2))
              .toDouble();

          emit(
            state.copyWith(
              state: v2rayStatus.status,
              country: localConnection.country,
              ip: localConnection.ip,
              protocol: localConnection.protocol,
              uploadSpeed: uploadSpeed,
              downloadSpeed: downloadSpeed,
            ),
          );
        }

        break;
    }
  }

  Future<void> _onVpnConnectionExecuted(
      VpnConnectionExecutedEvent event, Emitter<VpnState> emit) async {
    final Country country = state.country!;
    final Protocols protocol = state.protocol!;

    emit(state.copyWith(state: States.loading));

    try {
      await _refreshUser();

      final String url = await createSession(
        user: _userRepository.get(),
        country: country,
        protocol: protocol,
      );

      _vpnConnectionRepository.put(
        vpnConnection: VpnConnection(
          state: States.connected,
          country: country,
          ip: const IP.unknown(),
          protocol: protocol,
        ),
      );

      final V2RayURL v2rayURL = FlutterV2ray.parseFromURL(url);

      if (await _flutterV2ray.requestPermission()) {
        await _flutterV2ray.startV2Ray(
          config: v2rayURL.getFullConfiguration(),
          remark: v2rayURL.remark,
          notificationTitle:
              "Подключено ${country.countryName} ${protocol.name}",
          notificationDisconnectButtonName: "Отключиться",
        );
      } else {
        emit(VpnState.error(error: "Permission error", thrownBy: event));
      }
    } on Auth catch (e) {
      emit(VpnState.authError(error: e, thrownBy: event));
    } catch (e) {
      emit(VpnState.error(error: "Connect error", thrownBy: event));
    }
  }

  Future<void> _onVpnConnectionDisconnected(
    VpnConnectionDisconnectedEvent event,
    Emitter<VpnState> emit,
  ) async {
    emit(state.copyWith(state: States.loading));

    _blockConnectedV2rayStatus = true;

    try {
      await _flutterV2ray.stopV2Ray();

      _blockConnectedV2rayStatus = false;
    } catch (e) {
      emit(VpnState.error(error: 'Disconnect error', thrownBy: event));
    }
  }

  void _onChangeSelectedServer(
          ChangeSelectedServerEvent event, Emitter<VpnState> emit) =>
      emit(state.copyWith(
        country: event.country,
        protocol: event.protocol,
      ));

  Future<void> _refreshUser() async {
    final User refreshedUser = await refresh(_userRepository.get());
    _userRepository.put(user: refreshedUser);
  }
}
