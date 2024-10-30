import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:Helios/common/server/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/mappers.dart';

import 'package:Helios/repositories/session_repository/mappers/create_session_server_entity_mapper.dart';

Future<BasicServerEntity> serverCreateSession({
  required String accessToken,
  required String country,
  required String protocol,
}) async {
  final headers = {
    "Authorization": "Bearer $accessToken",
  };

  final data = {
    "country": country,
    "protocol": protocol,
  };

  final Response<dynamic> result;

  if (!kDebugMode) {
    result = await dio.request(
      "session",
      options: Options(
        method: "POST",
        headers: headers,
      ),
      data: data,
    );
  } else {
    await Future.delayed(const Duration(seconds: 1));

    result = Response<dynamic>(
      requestOptions: RequestOptions(),
      data: <String, dynamic>{
        "data": {
          "link": dotenv.get("TEST_${protocol.toUpperCase()}_URL"),
          "session_id": 1,
        },
        "message": "Session created successfully",
      },
      statusCode: 201,
    );
  }

  BasicResponse response = switch (result.statusCode) {
    201 => responseMapper(
        json: result.data,
      ),
    _ => errorResponseMapper(
        json: result.data,
      ),
  };

  return createSessionServerEntityMapper(response: response);
}
