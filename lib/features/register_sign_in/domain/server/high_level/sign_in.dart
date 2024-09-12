import 'package:flutter/material.dart';

import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/common/user/user_provider.dart';

import 'package:Helios/features/register_sign_in/domain/server/entities/sign_in_up_server_entity.dart';
import 'package:Helios/features/register_sign_in/domain/server/low_level/sign_in.dart';

import 'package:Helios/features/register_sign_in/domain/server/utils/create_user.dart';

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
