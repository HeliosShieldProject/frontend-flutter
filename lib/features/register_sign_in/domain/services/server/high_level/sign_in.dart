import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/server/response.dart';
import 'package:Helios/common/user/user_provider.dart';
import 'package:Helios/features/register_sign_in/domain/services/server/entities/sign_in_server_entity.dart';
import 'package:Helios/features/register_sign_in/domain/services/server/utils/create_user.dart';
import 'package:Helios/features/register_sign_in/domain/services/server/low_level/sign_in.dart';
import 'package:flutter/material.dart';

Future<Auth> signIn(BuildContext context,
    {required String email, required String password}) async {
  User user = await createUser(email: email, password: password);

  final BasicServerEntity response;

  try {
    response = await serverSignIn(
      user: user,
    );
  } catch (e) {
    return Auth.failed;
  }

  if (response.status != Auth.success) {
    return response.status;
  } else if (context.mounted) {
    response as SignInUpServerEntity;
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
