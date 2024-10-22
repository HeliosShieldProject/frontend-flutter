import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part '../generated/ip.g.dart';

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
