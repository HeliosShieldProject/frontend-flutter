import 'package:Helios/repositories/local_repository/hive_keys.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:hive/hive.dart';

bool deleteLocalConnection() {
  try {
    final Box<VpnConnection> vpnConnectionBox =
        Hive.box<VpnConnection>(HiveKeys.vpnConnectionBox);
    vpnConnectionBox.delete(HiveKeys.userSettingsKey);
  } catch (e) {
    return false;
  }

  return true;
}
