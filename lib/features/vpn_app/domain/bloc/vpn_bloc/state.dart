part of 'vpn_bloc.dart';

extension EnumedV2RayStatus on V2RayStatus {
  States get status => States.values.firstWhere(
        (state) => state.name == this.state,
        orElse: () => States.loading,
      );
}

enum States {
  loading(name: "LOADING"),
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
  final int? uploadSpeed;
  final int? downloadSpeed;
  final IP? ip;

  const VpnState.empty()
      : state = null,
        country = null,
        protocol = null,
        uploadSpeed = null,
        downloadSpeed = null,
        ip = null;

  VpnState copyWith({
    States? state,
    Country? country,
    Protocols? protocol,
    int? uploadSpeed,
    int? downloadSpeed,
    IP? ip,
  }) =>
      VpnState(
        state: state ?? this.state,
        country: country ?? this.country,
        protocol: protocol ?? this.protocol,
        uploadSpeed: uploadSpeed ?? this.uploadSpeed,
        downloadSpeed: downloadSpeed ?? this.downloadSpeed,
        ip: ip ?? this.ip,
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
