import 'package:flutter/material.dart';

import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/common/user/user_provider.dart';

import 'package:Helios/repositories/auth_repository/entities/sign_in_up_server_entity.dart';
import 'package:Helios/repositories/auth_repository/low_level/sign_in.dart';

import 'package:Helios/repositories/auth_repository/utils/create_user.dart';

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
      user.copyWith(
        jwtRefreshToken: response.refreshToken,
        jwtToken: response.accessToken,
      ),
    );
    return response.status;
  }
  return Auth.failed;
}
