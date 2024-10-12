import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/repositories/auth_repository/entities/sign_in_up_server_entity.dart';
import 'package:Helios/repositories/auth_repository/low_level/sign_up.dart';

import 'package:Helios/repositories/auth_repository/utils/create_user.dart';

Future<User> signUp({required String email, required String password}) async {
  User user = await createUser(email: email, password: password);

  final BasicServerEntity response;

  try {
    response = await serverSignUp(
      user: user,
    );
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }

  response as SignInUpServerEntity;
  return user.copyWith(
    jwtToken: response.accessToken,
    jwtRefreshToken: response.refreshToken,
  );
}
