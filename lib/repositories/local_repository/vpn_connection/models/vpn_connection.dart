import 'package:Helios/common/constants/countries_constants.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/ip.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part '../generated/vpn_connection.g.dart';

@HiveType(typeId: 4)
@immutable
class VpnConnection extends Equatable {
  const VpnConnection({
    required this.country,
    required this.ip,
    required this.protocol,
    required this.state,
  });

  static const VpnConnection basic = VpnConnection(
    country: CountriesConstants.uk,
    ip: IP.unknown(),
    protocol: Protocols.vless,
    state: States.disconnected,
  );

  VpnConnection copyWith({
    Country? country,
    IP? ip,
    Protocols? protocol,
    States? state,
  }) =>
      VpnConnection(
        country: country ?? this.country,
        ip: ip ?? this.ip,
        protocol: protocol ?? this.protocol,
        state: state ?? this.state,
      );

  @HiveField(0)
  final Country country;
  @HiveField(1)
  final IP ip;
  @HiveField(2)
  final Protocols protocol;
  @HiveField(3)
  final States state;

  @override
  List<Object?> get props => [country, ip, protocol, state];
}
