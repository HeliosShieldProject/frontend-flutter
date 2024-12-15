import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/server/dio.dart';
import 'package:Helios/common/server/mappers/mappers.dart';
import 'package:Helios/repositories/auth_repository/mappers/change_password_server_entity_mapper.dart';

Future<BasicServerEntity> serverChangePassword(
    {required String accessToken, required String newPassword}) async {
  final Map<String, dynamic> headers = <String, dynamic>{
    "Authentication": 'Bearer  $accessToken',
  };
  final Map<String, dynamic> body = <String, dynamic>{
    "password": newPassword,
  };

  late final Response<dynamic> result;
  if (!kDebugMode) {
    result = await dio.request(
      "/auth/change-password",
      data: body,
      options: Options(
        method: "PUT",
        headers: headers,
      ),
    );
  } else {
    await Future.delayed(const Duration(seconds: 1));

    result = Response(
      requestOptions: RequestOptions(),
      statusCode: 200,
      data: <String, dynamic>{
        "message": "Changed password successfully",
      },
    );
  }

  final BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(json: result.data),
    _ => errorResponseMapper(json: result.data),
  };

  return changePasswordServerEntityMapper(response: response);
}
