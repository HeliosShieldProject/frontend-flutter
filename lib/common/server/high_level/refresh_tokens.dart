import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/server/entitties/refresh_server_entity.dart';
import 'package:Helios/common/server/low_level/refresh_tokens.dart';

Future<Auth> refresh(User user) async {
  final BasicServerEntity response;

  try {
    response = await serverRefresh(
      user: user,
    );
  } catch (e) {
    return Auth.failed;
  }

  if (response.status != Auth.success) {
    return response.status;
  } else {
    response as RefreshServerEntity;
    user = user.copyWith(
      jwtRefreshToken: response.refreshToken,
      jwtToken: response.accessToken,
    );
    return response.status;
  }
}
