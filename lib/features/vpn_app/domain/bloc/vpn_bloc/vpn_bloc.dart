import 'dart:math';

import 'package:Helios/common/constants/countries_constants.dart';
import 'package:country_ip/country_ip.dart';
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
    on<DisconnectedStateEvent>(_onDisconnectedState);
  }

  final UserRepository _userRepository;
  final VpnConnectionRepository _vpnConnectionRepository;
  late final FlutterV2ray _flutterV2ray;

  bool _blockV2rayStatus = false;

  Future<void> _onVpnAppInit(
      VpnAppInitEvent event, Emitter<VpnState> emit) async {
    _flutterV2ray = FlutterV2ray(
      onStatusChanged: (status) => add(VpnStatusChangedEvent(status: status)),
    );

    emit(
      state.copyWith(state: States.loading),
    );

    try {
      await _flutterV2ray.initializeV2Ray();

      final States v2rayState = await _flutterV2ray.state;
      final States localState = _vpnConnectionRepository.get().state;

      if ((v2rayState == States.disconnected || v2rayState == States.error) &&
          localState == States.connected) {
        await _refreshUser();

        await closeSession(user: _userRepository.get());

        _vpnConnectionRepository.delete();
      }

      emit(
        state.copyWith(state: v2rayState),
      );
    } catch (e) {
      emit(
        const VpnState.error(errorMessage: "Init error"),
      );
    }
  }

  Future<void> _onVpnStatusChanged(
      VpnStatusChangedEvent event, Emitter<VpnState> emit) async {
    final VpnConnection localVpnConnection = _vpnConnectionRepository.get();
    final V2RayStatus v2rayStatus = event.status;

    switch ((v2rayStatus.status, localVpnConnection.state)) {
      case (States.error, _):
        emit(
          const VpnState.error(errorMessage: 'V2ray error'),
        );

        if (localVpnConnection.state == States.connected) {
          try {
            await _refreshUser();

            await closeSession(user: _userRepository.get());

            _vpnConnectionRepository.delete();

            await _flutterV2ray.stopV2Ray();
          } catch (e) {
            emit(
              const VpnState.error(errorMessage: 'Disconnect error'),
            );
          }
        }

        break;
      case (States.disconnected, States.connected):
        try {
          await _refreshUser();

          await closeSession(user: _userRepository.get());

          _vpnConnectionRepository.delete();

          emit(
            const VpnState.disconnected(),
          );
        } catch (e) {
          emit(
            const VpnState.error(errorMessage: 'Close session error'),
          );
        }

        break;
      case (States.disconnected, States.disconnected):
        emit(
          const VpnState.disconnected(),
        );

        break;
      default:
        if (!_blockV2rayStatus) {
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
              country: localVpnConnection.country,
              ip: localVpnConnection.ip,
              protocol: localVpnConnection.protocol,
              uploadSpeed: uploadSpeed,
              downloadSpeed: downloadSpeed,
            ),
          );
        }
    }
  }

  Future<void> _onVpnConnectionExecuted(
      VpnConnectionExecutedEvent event, Emitter<VpnState> emit) async {
    final Country country = event.country;
    final Protocols protocol = event.protocol;

    emit(
      state.copyWith(state: States.loading),
    );

    try {
      await _refreshUser();

      final String url = await createSession(
        user: _userRepository.get(),
        country: country,
        protocol: protocol,
      );

      _vpnConnectionRepository.put(
        vpnConnection: VpnConnection(
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
        );
      } else {
        emit(
          const VpnState.error(errorMessage: "Permission error"),
        );
      }
    } catch (e) {
      emit(
        const VpnState.error(errorMessage: "Connect error"),
      );
    }
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

    _blockV2rayStatus = true;

    try {
      await _refreshUser();

      await closeSession(user: _userRepository.get());

      _vpnConnectionRepository.delete();

      await _flutterV2ray.stopV2Ray();

      _blockV2rayStatus = false;
    } catch (e) {
      emit(
        const VpnState.error(errorMessage: 'Disconnect error'),
      );
    }
  }

  Future<void> _onDisconnectedState(
      DisconnectedStateEvent event, Emitter<VpnState> emit) async {
    final CountryResponse? countryInfo = await CountryIp.find();

    if (countryInfo case CountryResponse _) {
      final Country curCountry = CountriesConstants.values.firstWhere(
        (val) => val.countryCode == countryInfo.countryCode,
        orElse: () => CountriesConstants.unknown,
      );

      emit(
        state.copyWith(
          country: curCountry,
          ip: IP.parse(countryInfo.ip),
        ),
      );
    } else {
      emit(
        const VpnState.error(errorMessage: "Country lookup"),
      );
    }
  }

  @override
  void onChange(Change<VpnState> change) {
    if (change.currentState.state != States.disconnected &&
        change.nextState.state == States.disconnected) {
      add(
        DisconnectedStateEvent(),
      );
    }
    super.onChange(change);
  }

  Future<void> _refreshUser() async {
    final User refreshedUser = await refresh(_userRepository.get());
    _userRepository.put(user: refreshedUser);
  }
}
