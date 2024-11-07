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

    emit(
      state.copyWith(
        state: States.loading,
      ),
    );

    try {
      await _flutterV2ray.initializeV2Ray();
    } catch (e) {
      throw States.error;
    }
  }

  void _onVpnStatusChanged(
      VpnStatusChangedEvent event, Emitter<VpnState> emit) {
    final VpnConnection vpnConnection = _vpnConnectionRepository.get();
    final V2RayStatus v2rayStatus = event.status;

    if (v2rayStatus.status == States.error) {
      emit(
        state.copyWith(
          state: States.error,
        ),
      );

      _vpnConnectionRepository.delete();
      return;
    } else {
      print(vpnConnection.protocol);
      emit(
        state.copyWith(
          state: v2rayStatus.status,
          country: vpnConnection.country,
          ip: vpnConnection.ip,
          protocol: vpnConnection.protocol,
          uploadSpeed: v2rayStatus.uploadSpeed.toDouble(),
          downloadSpeed: v2rayStatus.downloadSpeed.toDouble(),
        ),
      );
      return;
    }
  }

  Future<void> _connectFromLocal(VpnConnection vpnConnection) async {
    V2RayURL url = FlutterV2ray.parseFromURL(vpnConnection.shareLink!);

    await _flutterV2ray.requestPermission();
    await _flutterV2ray.startV2Ray(
      remark: url.remark,
      config: url.getFullConfiguration(),
    );
  }

  Future<void> _disconnectLocal() async {
    await _flutterV2ray.stopV2Ray();
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

          if (!permission) throw States.error;

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
    );
  }
}
