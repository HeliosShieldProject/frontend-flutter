import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/dto.dart';
import 'package:Helios/repositories/auth_repository/entities/sign_out_server_entity.dart';

SignOutServerEntity signOutServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => const SignOutServerEntity(status: Auth.success),
    (ErrorResponse _) => SignOutServerEntity(
        status: Auth.values.firstWhere((val) => val.name == response.error)),
    _ => const SignOutServerEntity(status: Auth.failed),
  };
}
