part of 'vpn_bloc.dart';

extension EnumedV2RayStatus on V2RayStatus {
  States get status => States.values.firstWhere(
        (state) => state.name == this.state,
        orElse: () => States.disconnected,
      );
}

extension EnumedFlutterV2ray on FlutterV2ray {
  Future<States> get state async {
    final String status = await getV2rayStatus();

    return States.values.firstWhere(
      (state) => status == state.name,
      orElse: () => States.error,
    );
  }
}

@HiveType(typeId: 9)
enum States {
  @HiveField(0)
  loading(name: "CONNECTING"),
  @HiveField(1)
  connected(name: "CONNECTED"),
  @HiveField(2)
  disconnected(name: "DISCONNECTED"),
  @HiveField(3)
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

  static const VpnState empty = VpnState(
    state: null,
    country: null,
    protocol: null,
    uploadSpeed: null,
    downloadSpeed: null,
    ip: null,
  );

  const factory VpnState.error(
      {required String error, required VpnEvent thrownBy}) = ErrorVpnState;

  const factory VpnState.authError(
      {required Auth error, required VpnEvent thrownBy}) = ErrorVpnState;

  VpnState copyWith({
    States? state,
    Country? country,
    Protocols? protocol,
    double? uploadSpeed,
    double? downloadSpeed,
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

@immutable
class ErrorVpnState<T> extends VpnState {
  const ErrorVpnState({
    required this.error,
    required this.thrownBy,
  }) : super(
          state: States.error,
          country: null,
          protocol: null,
          uploadSpeed: null,
          downloadSpeed: null,
          ip: null,
        );

  final T error;
  final VpnEvent thrownBy;
}
