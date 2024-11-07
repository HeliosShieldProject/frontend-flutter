import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/dto.dart';

import 'package:Helios/repositories/auth_repository/entities/sign_in_up_server_entity.dart';

SignInUpServerEntity signInUpServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => SignInUpServerEntity(
        accessToken:
            (response.data as Map<String, dynamic>)["access_token"].toString(),
        refreshToken:
            (response.data as Map<String, dynamic>)["refresh_token"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => SignInUpServerEntity.error(
        status: Auth.values.firstWhere(
          (e) => e.name == response.error,
          orElse: () => Auth.failed,
        ),
      ),
    _ => const SignInUpServerEntity.error(
        status: Auth.failed,
      ),
  };
}
