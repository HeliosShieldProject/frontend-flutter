import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/vpn_connection.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/vpn_connection.dart';

class VpnConnectionRepository {
  VpnConnection? _vpnConnection;

  /// get the current stored VpnConnection
  VpnConnection get() {
    if (_vpnConnection != null) {
      return _vpnConnection!;
    }
    _vpnConnection = getLocalConnection();
    return _vpnConnection!;
  }

  /// put new VpnConnection
  bool put({required VpnConnection vpnConnection}) {
    _vpnConnection = vpnConnection;
    return putLocalConnection(
      vpnConnection: _vpnConnection ?? VpnConnection.basic,
    );
  }

  /// reset current storred VpnConnection
  /// to have Disconnected state
  bool reset() {
    _vpnConnection = _vpnConnection?.copyWith(state: States.disconnected);
    return putLocalConnection(
      vpnConnection: _vpnConnection ?? VpnConnection.basic,
    );
  }

  /// delet the currently stored connection info
  Future<void> delete() async {
    _vpnConnection = null;
    await deleteLocalConnection();
  }
}
