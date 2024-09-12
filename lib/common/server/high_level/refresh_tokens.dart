import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/server/entitties/refresh_server_entity.dart';
import 'package:Helios/common/server/low_level/refresh_tokens.dart';
import 'package:Helios/common/user/user_provider.dart';
import 'package:flutter/material.dart';

Future<Auth> refresh(BuildContext context) async {
  User user = AppUser.of(context)!;

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
  } else if (context.mounted) {
    response as RefreshServerEntity;
    AppUser.update(
      context,
      user
        ..jwtToken = response.accessToken
        ..jwtRefreshToken = response.refreshToken,
    );
    return response.status;
  }
  return Auth.failed;
}
