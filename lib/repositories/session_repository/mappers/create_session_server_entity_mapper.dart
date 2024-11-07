import 'package:Helios/common/interafces/basic_response.dart';

import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';

import 'package:Helios/repositories/session_repository/entities/create_session_server_entity.dart';

import 'package:Helios/common/enums/enums.dart';

CreateSessionServerEntity createSessionServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => CreateSessionServerEntity(
        link: (response.data as Map<String, dynamic>)["link"].toString(),
        sessionId:
            (response.data as Map<String, dynamic>)["session_id"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => CreateSessionServerEntity.error(
        status: Auth.values.firstWhere(
          (status) => status.name == response.error,
          orElse: () => Auth.failed,
        ),
      ),
    (_) => const CreateSessionServerEntity.error(
        status: Auth.failed,
      ),
  };
}
