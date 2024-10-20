import 'package:dio/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/error_response_mapper.dart';
import 'package:Helios/common/server/mappers/response_mapper.dart';

import 'package:Helios/repositories/vpn_repository/mappers/create_session_server_entity_mapper.dart';

import 'package:Helios/common/server/dio.dart';

Future<BasicServerEntity> createSession(
    {required String accessToken, required String country}) async {
  final headers = {
    "Authorization": "Bearer $accessToken",
  };

  final data = {
    "country": country,
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
