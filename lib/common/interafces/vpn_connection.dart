import 'package:Helios/common/interafces/country.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'vpn_connection.g.dart';

@HiveType(typeId: 4)
@immutable
class VpnConnection extends Equatable {
  const VpnConnection({
    required this.country,
    required this.ip,
    required this.protocol,
    required this.shareLink,
  });

  @HiveField(0)
  final Country country;
  @HiveField(1)
  final IP ip;
  @HiveField(2)
  final Protocols protocol;
  @HiveField(3)
  final String shareLink;

  @override
  List<Object?> get props => [country, ip, protocol, shareLink];
}

@HiveType(typeId: 5)
@immutable
class IP {
  const IP(
    this.firstByte,
    this.secondByte,
    this.thirdByte,
    this.fourthByte,
  ) : assert(firstByte < 255 &&
            secondByte < 255 &&
            thirdByte < 255 &&
            fourthByte < 2555);

  @HiveField(0)
  final int firstByte;
  @HiveField(1)
  final int secondByte;
  @HiveField(2)
  final int thirdByte;
  @HiveField(3)
  final int fourthByte;

  @override
  String toString() => "$firstByte.$secondByte.$thirdByte.$fourthByte";
}

@HiveType(typeId: 7)
enum Protocols {
  @HiveField(0)
  vless,
  @HiveField(1)
  ss,
}
