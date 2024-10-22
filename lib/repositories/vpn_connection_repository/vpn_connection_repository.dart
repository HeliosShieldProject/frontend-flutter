import 'package:Helios/repositories/local_repository/vpn_connection/delete_connection.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/get_connection.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/put_connection.dart';

class VpnConnectionRepository {
  VpnConnection? _vpnConnection;

  VpnConnection get() {
    if (_vpnConnection != null) {
      return _vpnConnection!;
    }
    _vpnConnection = getLocalConnection();
    return _vpnConnection!;
  }

  bool put({required VpnConnection vpnConnection}) {
    _vpnConnection = vpnConnection;
    return putLocalConnection(
      vpnConnection: _vpnConnection ?? const VpnConnection.empty(),
    );
  }

  bool delete() {
    _vpnConnection = null;
    return deleteLocalConnection();
  }
}
