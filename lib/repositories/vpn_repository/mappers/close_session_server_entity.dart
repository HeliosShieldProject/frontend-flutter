import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';
import 'package:Helios/repositories/vpn_repository/entities/close_session_server_entity.dart';

CloseSessionServerEntity closeSessionServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response.runtimeType) {
    (Response _) => CloseSessionServerEntity(
        message:
            ((response as Response).message as Map<String, dynamic>)["message"]
                .toString(),
        status: Auth.success),
    (ErrorResponse _) => CloseSessionServerEntity.error(
        status: Auth.values.firstWhere(
            (status) => status.name == (response as ErrorResponse).error,
            orElse: () => Auth.failed),
      ),
    (Type()) => const CloseSessionServerEntity.error(status: Auth.failed),
  };
}
