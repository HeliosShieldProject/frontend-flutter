import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part '../generated/ip.g.dart';

@HiveType(typeId: 5)
@immutable
class IP extends Equatable {
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

  const IP.unknown()
      : firstByte = 196,
        secondByte = 128,
        thirdByte = 15,
        fourthByte = 16;

  static IP parse(String ip) {
    final List<int> bytes =
        ip.split(".").map((byte) => int.parse(byte)).toList();

    return IP(
      bytes[0],
      bytes[1],
      bytes[2],
      bytes[3],
    );
  }

  @override
  List<Object> get props => [
        firstByte,
        secondByte,
        thirdByte,
        fourthByte,
      ];

  @override
  String toString() => "$firstByte.$secondByte.$thirdByte.$fourthByte";
}
