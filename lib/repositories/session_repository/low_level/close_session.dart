import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:Helios/common/server/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/mappers.dart';

import 'package:Helios/repositories/session_repository/mappers/close_session_server_entity.dart';

Future<BasicServerEntity> serverCloseSession(
    {required String accessToken}) async {
  final Map<String, dynamic> headers = {
    "Authentication": "Bearer $accessToken",
  };

  final Response<dynamic> result;
  if (kDebugMode) {
    result = await dio.request(
      "session",
      options: Options(
        method: "PUT",
        headers: headers,
      ),
    );
  } else {
    await Future.delayed(const Duration(seconds: 1));

    result = Response(
      requestOptions: RequestOptions(),
      data: <String, dynamic>{
        "message": "Session closed successfully",
      },
      statusCode: 200,
    );
  }

  final BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(
        json: result.data,
      ),
    _ => errorResponseMapper(json: result.data),
  };

  return closeSessionServerEntityMapper(response: response);
}
