part of 'vpn_bloc.dart';

extension EnumedV2RayStatus on V2RayStatus {
  States get status => States.values.firstWhere(
        (state) => state.name == this.state,
        orElse: () => States.disconnected,
      );
}

enum States {
  loading(name: "CONNECTING"),
  connected(name: "CONNECTED"),
  disconnected(name: "DISCONNECTED"),
  error(name: "ERROR");

  const States({
    required this.name,
  });

  final String name;
}

@immutable
class VpnState extends Equatable {
  const VpnState({
    required this.state,
    required this.country,
    required this.protocol,
    required this.uploadSpeed,
    required this.downloadSpeed,
    required this.ip,
  });

  final States? state;
  final Country? country;
  final Protocols? protocol;
  final double? uploadSpeed;
  final double? downloadSpeed;
  final IP? ip;

  const VpnState.empty()
      : state = null,
        country = null,
        protocol = null,
        uploadSpeed = null,
        downloadSpeed = null,
        ip = null;

  const VpnState.disconnected()
      : state = States.disconnected,
        country = null,
        protocol = null,
        uploadSpeed = null,
        downloadSpeed = null,
        ip = null;

  VpnState copyWith({
    States? state,
    Country? country,
    Protocols? protocol,
    double? uploadSpeed,
    double? downloadSpeed,
    IP? ip,
  }) =>
      state != States.disconnected
          ? VpnState(
              state: state ?? this.state,
              country: country ?? this.country,
              protocol: protocol ?? this.protocol,
              uploadSpeed: uploadSpeed ?? this.uploadSpeed,
              downloadSpeed: downloadSpeed ?? this.downloadSpeed,
              ip: ip ?? this.ip,
            )
          : VpnState(
              state: state,
              country: country,
              protocol: protocol,
              uploadSpeed: uploadSpeed,
              downloadSpeed: downloadSpeed,
              ip: ip,
            );

  @override
  List<Object?> get props => [
        state,
        country,
        protocol,
        uploadSpeed,
        downloadSpeed,
        ip,
      ];
}
