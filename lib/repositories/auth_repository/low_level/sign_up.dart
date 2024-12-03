import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/repositories/auth_repository/mappers/sign_in_up_server_entity_mapper.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:Helios/common/interafces/user.dart';

import 'package:Helios/common/server/mappers/mappers.dart';

import 'package:Helios/common/server/dio.dart';
import 'package:flutter/foundation.dart';

Future<BasicServerEntity> serverSignUp({required User user}) async {
  final Response<dynamic> result;

  if (!kDebugMode) {
    result = await dio.request(
      "/auth/sign-up",
      data: user.toJson(),
      options: Options(
        method: "POST",
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
      statusCode: 201,
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
        "message": "Signed Up succesfully"
      },
    );
  }

  final BasicResponse response = switch (result.statusCode) {
    201 => responseMapper(
        json: result.data,
      ),
    int() || null => errorResponseMapper(
        json: result.data,
      ),
  };

  return signInUpServerEntityMapper(response: response);
}
