part of 'vpn_bloc.dart';

sealed class VpnEvent {}

class VpnAppInitEvent extends VpnEvent {}

class VpnStatusChanged extends VpnEvent {
  VpnStatusChanged({
    required this.status,
  });

  final V2RayStatus status;
}

class VpnConnectionExecuted extends VpnEvent {
  VpnConnectionExecuted({
    required this.country,
    required this.protocol,
  });

  final Country country;
  final Protocols protocol;
}
