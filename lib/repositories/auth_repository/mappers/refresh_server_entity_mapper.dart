import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';

import 'package:Helios/repositories/auth_repository/entities/refresh_server_entity.dart';

RefreshServerEntity refreshServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response) {
    (Response _) => RefreshServerEntity(
        accessToken:
            (response.data as Map<String, dynamic>)["access_token"].toString(),
        refreshToken:
            (response.data as Map<String, dynamic>)["refresh_token"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => RefreshServerEntity.error(
        status: Auth.values.firstWhere(
          (status) => status.name == response.error,
          orElse: () => Auth.failed,
        ),
      ),
    _ => RefreshServerEntity(
        accessToken: null,
        refreshToken: null,
        status: Auth.failed,
      ),
  };
}
