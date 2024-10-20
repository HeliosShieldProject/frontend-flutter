import 'package:dio/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/server/mappers/error_response_mapper.dart';
import 'package:Helios/common/server/mappers/response_mapper.dart';

import 'package:Helios/common/server/dio.dart';

import 'package:Helios/repositories/vpn_repository/mappers/close_session_server_entity.dart';

Future<BasicServerEntity> closeSession({required String accessToken}) async {
  final Map<String, dynamic> headers = {
    "Authentication": "Bearer $accessToken",
  };

  final result = await dio.request(
    "session",
    options: Options(
      method: "PUT",
      headers: headers,
    ),
  );

  final BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(
        json: result.data,
      ),
    _ => errorResponseMapper(json: result.data),
  };

  return closeSessionServerEntityMapper(response: response);
}
