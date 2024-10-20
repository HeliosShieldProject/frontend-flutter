import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/repositories/local_repository/vpn/models/ip.dart';
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
    required this.shareLink,
  });

  const VpnConnection.empty()
      : country = null,
        ip = null,
        protocol = null,
        shareLink = null;

  @HiveField(0)
  final Country? country;
  @HiveField(1)
  final IP? ip;
  @HiveField(2)
  final Protocols? protocol;
  @HiveField(3)
  final String? shareLink;

  @override
  List<Object?> get props => [country, ip, protocol, shareLink];
}
