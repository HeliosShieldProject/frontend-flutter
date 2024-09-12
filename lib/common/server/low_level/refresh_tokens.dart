import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/common/server/dio.dart';
import 'package:dio/dio.dart';

import 'package:Helios/common/server/mappers/mappers.dart';

Future<BasicServerEntity> serverRefresh({required User user}) async {
  var headers = {
    "Authorization": "Bearer ${user.jwtRefreshToken}",
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
    int() || null => errorResponseMapper(
        json: result.data,
      ),
  };

  return refreshServerEntityMapper(
    response: response,
  );
}
