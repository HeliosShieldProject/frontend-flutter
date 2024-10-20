import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/repositories/auth_repository/entities/refresh_server_entity.dart';
import 'package:Helios/repositories/auth_repository/low_level/refresh_tokens.dart';

Future<User> refresh(User user) async {
  final BasicServerEntity response;

  try {
    response = await serverRefresh(
      jwtRefreshToken: user.jwtRefreshToken!,
    );
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }

  response as RefreshServerEntity;
  return user.copyWith(
    jwtRefreshToken: response.refreshToken,
    jwtToken: response.accessToken,
  );
}
