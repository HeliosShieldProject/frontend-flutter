import 'package:dio/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/error_response_mapper.dart';
import 'package:Helios/common/server/mappers/response_mapper.dart';

import 'package:Helios/repositories/session_repository/mappers/create_session_server_entity_mapper.dart';

import 'package:Helios/common/server/dio.dart';

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

  final result = await dio.request(
    "session",
    options: Options(
      method: "POST",
      headers: headers,
    ),
    data: data,
  );

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
