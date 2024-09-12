import 'package:Helios/common/enums/enums.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/server/dto/error_response.dart';
import 'package:Helios/common/server/dto/response.dart';

import 'package:Helios/common/server/entitties/refresh_server_entity.dart';

RefreshServerEntity refreshServerEntityMapper(
    {required BasicResponse response}) {
  return switch (response.runtimeType) {
    (Response _) => RefreshServerEntity(
        accessToken:
            ((response as Response).data as Map<String, dynamic>)["data"]
                .toString(),
        refreshToken:
            (response.data as Map<String, dynamic>)["data"].toString(),
        status: Auth.success,
      ),
    (ErrorResponse _) => RefreshServerEntity(
        accessToken: null,
        refreshToken: null,
        status: Auth.values.firstWhere(
          (e) => e.name == (response as ErrorResponse).error,
        ),
      ),
    Type() => RefreshServerEntity(
        accessToken: null,
        refreshToken: null,
        status: Auth.failed,
      ),
  };
}
