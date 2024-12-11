import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import 'package:Helios/common/interafces/basic_response.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/server/dio.dart';
import 'package:Helios/common/server/mappers/mappers.dart';
import 'package:Helios/repositories/auth_repository/mappers/sign_out_server_entity_mapper.dart';

Future<BasicServerEntity> serverSignOut({required String accessToken}) async {
  final Map<String, dynamic> headers = {
    "Authorization": "Bearer $accessToken",
  };

  late final Response<dynamic> result;
  if (!kDebugMode) {
    result = await dio.request(
      "auth/logout",
      options: Options(
        headers: headers,
        method: "POST",
      ),
    );
  } else {
    result = Response<dynamic>(
      requestOptions: RequestOptions(),
      statusCode: 200,
      data: <String, dynamic>{"message": "Logged out successfully"},
    );
  }

  BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(json: result.data),
    _ => errorResponseMapper(json: result.data),
  };

  return signOutServerEntityMapper(response: response);
}
