import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/server/response.dart';
import 'package:Helios/features/register_sign_in/domain/services/server/entities/sign_in_up_server_entity.dart';

SignInUpServerEntity signInUpServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response.runtimeType) {
    (Response _) => SignInUpServerEntity(
        accessToken:
            ((response as Response).data as Map<String, dynamic>)["data"]
                .toString(),
        refreshToken:
            (response.data as Map<String, dynamic>)["data"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => SignInUpServerEntity(
        accessToken: null,
        refreshToken: null,
        status: Auth.values.firstWhere(
          (e) => e.name == (response as ErrorResponse).error,
        ),
      ),
    Type() => SignInUpServerEntity(
        accessToken: null,
        refreshToken: null,
        status: Auth.failed,
      ),
  };
}
