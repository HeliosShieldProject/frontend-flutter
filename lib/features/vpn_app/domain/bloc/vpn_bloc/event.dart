part of 'vpn_bloc.dart';

sealed class VpnEvent {}

class VpnAppInitEvent extends VpnEvent {}

class VpnStatusChangedEvent extends VpnEvent {
  VpnStatusChangedEvent({
    required this.status,
  });

  final V2RayStatus status;
}

class VpnConnectionExecutedEvent extends VpnEvent {
  VpnConnectionExecutedEvent({
    required this.country,
    required this.protocol,
  });

  final Country country;
  final Protocols protocol;
}

class VpnConnectionTriggeredEvent extends VpnEvent {
  VpnConnectionTriggeredEvent({
    required this.country,
    required this.protocol,
  });

  final Country country;
  final Protocols protocol;
}

class VpnConnectionDisconnectedEvent extends VpnEvent {}
