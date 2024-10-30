import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/session_repository/low_level/close_session.dart';

Future<void> closeSession({required User user}) async {
  BasicServerEntity response;

  try {
    response = await serverCloseSession(accessToken: user.jwtToken!);
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }
}
