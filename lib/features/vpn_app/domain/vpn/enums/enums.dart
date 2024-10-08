import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 5)
enum Protocol {
  @HiveField(0)
  vless,
  @HiveField(1)
  shadowsocks,
}

@HiveType(typeId: 6)
enum Status {
  @HiveField(0)
  connected,
  @HiveField(1)
  disconnected,
  @HiveField(2)
  restoring,
}
