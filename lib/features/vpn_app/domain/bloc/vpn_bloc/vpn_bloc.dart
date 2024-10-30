import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/ip.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';

part 'event.dart';
part 'state.dart';

class VpnBloc extends Bloc<VpnEvent, VpnState> {
  VpnBloc({
    required this.userRepository,
    required this.vpnConnectionRepository,
  }) : super(const VpnState.empty()) {
    on<VpnAppInitEvent>(onVpnAppInit);
    on<VpnStatusChangedEvent>(onVpnStatusChanged);
    on<VpnConnectionExecutedEvent>(onVpnConnectionExecuted);
    on<VpnConnectionExecutedEvent>(onVpnConnectionExecuted);
  }

  UserRepository userRepository;
  VpnConnectionRepository vpnConnectionRepository;
  late final FlutterV2ray flutterV2ray;

  Future<void> onVpnAppInit(
      VpnAppInitEvent event, Emitter<VpnState> emit) async {
    flutterV2ray = FlutterV2ray(
      onStatusChanged: (status) => add(VpnStatusChangedEvent(status: status)),
    );

    emit(
      state.copyWith(
        state: States.loading,
      ),
    );
    await flutterV2ray.initializeV2Ray();
  }

  void onVpnStatusChanged(VpnStatusChangedEvent event, Emitter<VpnState> emit) {
    final VpnConnection vpnConnection = vpnConnectionRepository.get();
    final V2RayStatus v2rayStatus = event.status;

    final States localState = vpnConnection.state;
    final States v2rayState = v2rayStatus.status;

    if (v2rayState == States.error) {
      emit(
        state.copyWith(
          state: States.error,
        ),
      );
      
      vpnConnectionRepository.delete();
      return;
    }
    if (localState == v2rayState) {
      emit(
        state.copyWith(
          state: v2rayState,
          country: vpnConnection.country,
          ip: vpnConnection.ip,
          protocol: vpnConnection.protocol,
          uploadSpeed: v2rayStatus.uploadSpeed,
          downloadSpeed: v2rayStatus.downloadSpeed,
        ),
      );
      return;
    }
    if (localState == States.connected && v2rayState == States.disconnected) {
      emit(
        state.copyWith(
          state: States.loading,
        ),
      );
      _connectFromLocal(vpnConnection, emit);
      return;
    }
    if (localState == States.disconnected && v2rayState == States.connected) {
      emit(
        state.copyWith(
          state: States.loading,
        ),
      );
      _disconnectLocal();
      return;
    }
  }

  Future<void> _connectFromLocal(
      VpnConnection vpnConnection, Emitter<VpnState> emit) async {
    V2RayURL url = FlutterV2ray.parseFromURL(vpnConnection.shareLink!);

    await flutterV2ray.startV2Ray(
      remark: url.remark,
      config: url.getFullConfiguration(),
    );
  }

  Future<void> _disconnectLocal() async {
    await flutterV2ray.stopV2Ray();
  }

  Future<void> onVpnConnectionExecuted(
      VpnConnectionExecutedEvent event, Emitter<VpnState> emit) async {
    final Country country = event.country;
    final Protocols protocol = event.protocol;
  }
}
