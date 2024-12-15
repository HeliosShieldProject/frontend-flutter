import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';
import 'package:Helios/repositories/auth_repository/entities/change_password_server_entity.dart';

ChangePasswordServerEntity changePasswordServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => const ChangePasswordServerEntity(status: Auth.success),
    (ErrorResponse _) => ChangePasswordServerEntity(
        status: Auth.values.firstWhere((value) => value.name == response.error,
            orElse: () => Auth.failed)),
    _ => const ChangePasswordServerEntity(status: Auth.failed),
  };
}
