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

    emit(
      state.copyWith(
        state: States.loading,
      ),
    );

    try {
      await _flutterV2ray.initializeV2Ray();
    } catch (e) {
      emit(
        const VpnState.error(),
      );
    } finally {
      final States v2rayState = await _flutterV2ray.state;
      final VpnConnection localConnection = _vpnConnectionRepository.get();

      if ((v2rayState == States.disconnected || v2rayState == States.error) &&
          localConnection.state == States.connected) {
        await _refreshUser(emit);

        await closeSession(user: _userRepository.get()).then(
          (_) async {
            _vpnConnectionRepository.delete();

            emit(
              state.copyWith(
                state: v2rayState,
              ),
            );
          },
          onError: (e, st) {
            emit(
              const VpnState.error(),
            );
          },
        );
      } else {
        emit(
          state.copyWith(
            state: v2rayState,
          ),
        );
      }
    }
  }

  Future<void> _onVpnStatusChanged(
      VpnStatusChangedEvent event, Emitter<VpnState> emit) async {
    final VpnConnection localVpnConnection = _vpnConnectionRepository.get();
    final V2RayStatus v2rayStatus = event.status;

    switch ((v2rayStatus.status, localVpnConnection.state)) {
      case (States.error, _):
        emit(
          const VpnState.error(),
        );

        if (localVpnConnection.state == States.connected) {
          await _refreshUser(emit);

          await closeSession(user: _userRepository.get()).then(
            (_) async {
              _vpnConnectionRepository.delete();
            },
            onError: (e, st) {
              emit(
                const VpnState.error(),
              );
            },
          );
        }

        break;
      case (States.disconnected, States.connected):
        await _refreshUser(emit);

        await closeSession(user: _userRepository.get()).then(
          (_) async {
            _vpnConnectionRepository.delete();

            emit(
              const VpnState.disconnected(),
            );
          },
          onError: (e, st) {
            emit(
              const VpnState.error(),
            );
          },
        );
      case (States.disconnected, States.disconnected):
        emit(
          const VpnState.disconnected(),
        );

        break;
      default:
        emit(
          state.copyWith(
            state: v2rayStatus.status,
            country: localVpnConnection.country,
            ip: localVpnConnection.ip,
            protocol: localVpnConnection.protocol,
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

        break;
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

        final V2RayURL url = FlutterV2ray.parseFromURL(shareLink);

        try {
          if (!(await _flutterV2ray.requestPermission())) {
            emit(
              const VpnState.error(),
            );
          } else {
            await _flutterV2ray.startV2Ray(
              remark: url.remark,
              config: url.getFullConfiguration(),
            );
          }
        } catch (e) {
          emit(
            const VpnState.error(),
          );
        }
      },
      onError: (error, st) {
        emit(
          const VpnState.error(),
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
            const VpnState.error(),
          );
        }
      },
      onError: (e, st) {
        emit(
          const VpnState.error(),
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
        const VpnState.error(),
      );
    }
  }
}
