import 'package:flutter/foundation.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
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

  late final Response<dynamic> result;
  if (!kDebugMode) {
    result = await dio.request(
      "auth/refresh",
      options: Options(
        method: "POST",
        headers: headers,
      ),
    );
  } else {
    await Future.delayed(const Duration(seconds: 1));

    JWT jwt = JWT(
      {
        "user": "Mock_user_id",
      },
    );
    result = Response(
      statusCode: 200,
      requestOptions: RequestOptions(),
      data: {
        "data": {
          "access_token": jwt.sign(
            SecretKey(
              "vey secret key",
            ),
            expiresIn: const Duration(
              days: 1,
            ),
          ),
          "refresh_token": jwt.sign(
            SecretKey(
              "vey secret key",
            ),
            expiresIn: const Duration(
              days: 2,
            ),
          ),
        },
        "message": "Token refreshed succesfully"
      },
    );
  }

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
