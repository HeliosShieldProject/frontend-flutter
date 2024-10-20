import 'package:Helios/common/interafces/basic_response.dart';

import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';

import 'package:Helios/repositories/vpn_repository/entities/create_session_server_entity.dart';

import 'package:Helios/common/enums/enums.dart';

CreateSessionServerEntity createSessionServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response.runtimeType) {
    (Response _) => CreateSessionServerEntity(
        sessionId: ((response as Response).message
                as Map<String, dynamic>)["session_id"]
            .toString(),
        url: (response.message as Map<String, dynamic>)["url"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => CreateSessionServerEntity.error(
        status: Auth.values.firstWhere(
          (status) => status.name == (response as ErrorResponse).error,
          orElse: () => Auth.failed,
        ),
      ),
    Type() => const CreateSessionServerEntity.error(
        status: Auth.failed,
      ),
  };
}
