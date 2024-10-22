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
    on<VpnStatusChanged>(onVpnStatusChanged);
  }

  UserRepository userRepository;
  VpnConnectionRepository vpnConnectionRepository;
  late final FlutterV2ray flutterV2ray;

  Future<void> onVpnAppInit(
      VpnAppInitEvent event, Emitter<VpnState> emit) async {
    flutterV2ray = FlutterV2ray(
      onStatusChanged: (status) => add(VpnStatusChanged(status: status)),
    );

    await flutterV2ray.initializeV2Ray();
  }

  void onVpnStatusChanged(VpnStatusChanged event, Emitter<VpnState> emit) {
    final VpnConnection vpnConnection = vpnConnectionRepository.get();

    final States v2rayState = event.status.status;
    final States localState =
        vpnConnection.isEmpty ? States.disconnected : States.connected;
  }
}
