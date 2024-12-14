import 'package:hive/hive.dart';

import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/local_repository/hive_keys.dart';

Future<void> deleteLocalConnection() async {
  await Hive.box<VpnConnection>(HiveKeys.vpnConnectionBox).clear();
}
