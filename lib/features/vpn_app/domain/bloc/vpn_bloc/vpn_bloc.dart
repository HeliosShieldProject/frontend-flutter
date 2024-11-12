import 'dart:math';

import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/auth_repository/high_level/refresh_tokens.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/country.dart';

import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/ip.dart';
import 'package:Helios/repositories/session_repository/high_level/close_session.dart';
import 'package:Helios/repositories/session_repository/high_level/create_session.dart';

part 'event.dart';
part 'state.dart';

extension EnumedFlutterV2ray on FlutterV2ray {
  Future<States> get state async {
    final String status = await getV2rayStatus();

    return States.values.firstWhere(
      (state) => status == state.name,
      orElse: () => States.error,
    );
  }
}

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  VpnBloc({
    required UserRepository userRepository,
    required VpnConnectionRepository vpnConnectionRepository,
  })  : _userRepository = userRepository,
        _vpnConnectionRepository = vpnConnectionRepository,
        super(const VpnState.empty()) {
    on<VpnAppInitEvent>(_onVpnAppInit);
    on<VpnStatusChangedEvent>(_onVpnStatusChanged);
    on<VpnConnectionExecutedEvent>(_onVpnConnectionExecuted);
    on<VpnConnectionDisconnectedEvent>(_onVpnConnectionDisconnected);
  }

  final UserRepository _userRepository;
  final VpnConnectionRepository _vpnConnectionRepository;
  late final FlutterV2ray _flutterV2ray;

  Future<void> _onVpnAppInit(
      VpnAppInitEvent event, Emitter<VpnState> emit) async {
    _flutterV2ray = FlutterV2ray(
      onStatusChanged: (status) => add(
        VpnStatusChangedEvent(
          status: status,
        ),
      ),
    );

    try {
      await _flutterV2ray.initializeV2Ray();
    } catch (e) {
      emit(
        state.copyWith(
          state: States.error,
        ),
      );
    } finally {
      final States state = await _flutterV2ray.state;
      print("init $state");
    }
  }

  Future<void> _onVpnStatusChanged(
      VpnStatusChangedEvent event, Emitter<VpnState> emit) async {
    final VpnConnection vpnConnection = _vpnConnectionRepository.get();
    final V2RayStatus v2rayStatus = event.status;

    print(v2rayStatus.status);

    switch ((v2rayStatus.status, vpnConnection.state)) {
      case (States.error, _):
        emit(state.copyWith(state: States.error));

        _vpnConnectionRepository.delete();

        emit(const VpnState.disconnected());

        return;
      case (States.disconnected, States.connected):
        await _refreshUser(emit);

        await closeSession(
          user: _userRepository.get(),
        ).then(
          (_) {
            _vpnConnectionRepository.delete();

            emit(const VpnState.disconnected());
          },
        );

        return;
      case (States.disconnected, States.disconnected):
        emit(const VpnState.disconnected());

        return;
      default:
        emit(
          state.copyWith(
            state: v2rayStatus.status,
            country: vpnConnection.country,
            ip: vpnConnection.ip,
            protocol: vpnConnection.protocol,
            uploadSpeed: num.parse(
                    (v2rayStatus.uploadSpeed.toDouble() / pow(2, 20))
                        .toStringAsFixed(2))
                .toDouble(),
            downloadSpeed: num.parse(
                    (v2rayStatus.downloadSpeed.toDouble() / pow(2, 20))
                        .toStringAsFixed(2))
                .toDouble(),
          ),
        );

        return;
    }
  }

  Future<void> _onVpnConnectionExecuted(
      VpnConnectionExecutedEvent event, Emitter<VpnState> emit) async {
    final Country country = event.country;
    final Protocols protocol = event.protocol;

    emit(
      state.copyWith(
        state: States.loading,
      ),
    );

    await _refreshUser(emit);

    await createSession(
      user: _userRepository.get(),
      country: country,
      protocol: protocol,
    ).then(
      (String shareLink) async {
        _vpnConnectionRepository.put(
          vpnConnection: VpnConnection(
            country: country,
            ip: const IP.unknown(),
            protocol: protocol,
            shareLink: shareLink,
          ),
        );

        V2RayURL url = FlutterV2ray.parseFromURL(shareLink);

        try {
          final bool permission = await _flutterV2ray.requestPermission();

          if (!permission) {
            emit(
              state.copyWith(
                state: States.error,
              ),
            );

            return;
          }

          await _flutterV2ray.startV2Ray(
            remark: url.remark,
            config: url.getFullConfiguration(),
          );
        } catch (e) {
          emit(
            state.copyWith(
              state: States.error,
            ),
          );
        }
      },
      onError: (error, st) {
        emit(
          state.copyWith(
            state: States.error,
          ),
        );
      },
    );
  }

  Future<void> _onVpnConnectionDisconnected(
    VpnConnectionDisconnectedEvent event,
    Emitter<VpnState> emit,
  ) async {
    emit(
      state.copyWith(
        state: States.loading,
      ),
    );

    await _refreshUser(emit);

    await closeSession(user: _userRepository.get()).then(
      (_) async {
        _vpnConnectionRepository.delete();

        try {
          await _flutterV2ray.stopV2Ray();
        } catch (e) {
          emit(
            state.copyWith(
              state: States.error,
            ),
          );
        }
      },
      onError: (e, st) {
        emit(
          state.copyWith(
            state: States.error,
          ),
        );
      },
    );
  }

  Future<void> _refreshUser(Emitter<VpnState> emit) async {
    try {
      final User refreshedUser = await refresh(_userRepository.get());
      _userRepository.put(user: refreshedUser);
    } catch (e) {
      emit(
        state.copyWith(
          state: States.error,
        ),
      );
    }
  }
}
