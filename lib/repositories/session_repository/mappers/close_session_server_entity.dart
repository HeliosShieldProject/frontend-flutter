import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';
import 'package:Helios/repositories/session_repository/entities/close_session_server_entity.dart';

CloseSessionServerEntity closeSessionServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => CloseSessionServerEntity(
        message: response.message,
        status: Auth.success,
      ),
    (ErrorResponse _) => CloseSessionServerEntity.error(
        status: Auth.values.firstWhere(
          (status) => status.name == response.error,
          orElse: () => Auth.failed,
        ),
      ),
    (_) => const CloseSessionServerEntity.error(
        status: Auth.failed,
      ),
  };
}
