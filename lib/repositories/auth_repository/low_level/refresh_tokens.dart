import 'package:dio/dio.dart';

import 'package:Helios/common/server/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/mappers.dart';

import 'package:Helios/repositories/auth_repository/mappers/refresh_server_entity_mapper.dart';

Future<BasicServerEntity> serverRefresh(
    {required String jwtRefreshToken}) async {
  final headers = {
    "Authorization": "Bearer $jwtRefreshToken",
  };

  final result = await dio.request(
    "auth/refresh",
    options: Options(
      method: "POST",
      headers: headers,
    ),
  );

  BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(
        json: result.data,
      ),
    _ => errorResponseMapper(
        json: result.data,
      ),
  };

  return refreshServerEntityMapper(
    response: response,
  );
}
