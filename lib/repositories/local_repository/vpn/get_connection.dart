import 'package:Helios/repositories/local_repository/hive_keys.dart';
import 'package:Helios/repositories/local_repository/vpn/models/vpn_connection.dart';
import 'package:hive/hive.dart';

VpnConnection get() {
  late final VpnConnection vpnConnection;

  try {
    final Box<VpnConnection> vpnConnectionBox =
        Hive.box<VpnConnection>(HiveKeys.vpnConnectionBox);
    vpnConnection = vpnConnectionBox.get(HiveKeys.vpnConnectionKey,
        defaultValue: const VpnConnection.empty())!;
  } catch (e) {
    return vpnConnection;
  }

  return vpnConnection;
}
