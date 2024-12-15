import 'dart:math';

import 'package:Helios/common/interafces/interfaces.dart';
import 'package:Helios/common/server/dio.dart';
import 'package:Helios/common/server/mappers/mappers.dart';
import 'package:Helios/repositories/session_repository/mappers/get_history_server_entity_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Future<BasicServerEntity> serverGetHistory({
  required String accessToken,
  int? limit,
  int? offset,
  List<String>? countries,
  List<String>? devices,
}) async {
  final Map<String, dynamic> headers = <String, dynamic>{
    "Authorization": "Bearer $accessToken",
  };

  final Map<String, dynamic> body = <String, dynamic>{
    if (limit != null) "limit": limit,
    if (offset != null) "offset": offset,
    if (countries != null) "countries": countries,
    if (devices != null) "devices": devices,
  };

  late final Response<dynamic> result;
  if (!kDebugMode) {
    result = await dio.request(
      "/session/history",
      data: body,
      options: Options(
        method: "GET",
        headers: headers,
      ),
    );
  } else {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    late final List<Map<String, dynamic>> splicedMockData;

    if (limit == null && offset == null) {
      splicedMockData = generatedMockData;
    } else if (offset! > generatedMockData.length) {
      splicedMockData = [];
    } else if (offset + limit! > generatedMockData.length) {
      splicedMockData = generatedMockData.sublist(offset);
    } else {
      splicedMockData = generatedMockData.sublist(offset, limit + offset);
    }

    final Map<String, dynamic> mockData = <String, dynamic>{
      "data": splicedMockData,
      "message": "Successfully got session history",
    };

    result = Response<dynamic>(
      requestOptions: RequestOptions(),
      statusCode: 200,
      data: mockData,
    );
  }

  final BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(json: result.data),
    _ => errorResponseMapper(json: result.data),
  };

  return getHistoryServerEntityMapper(response: response);
}

final List<Map<String, dynamic>> generatedMockData = _generateMockData(100);

List<Map<String, dynamic>> _generateMockData(int count) {
  final List<String> countries = ["UK", "US", "Germany"];
  final Random random = Random();
  final List<Map<String, dynamic>> data = [];

  for (int i = 0; i < count; i++) {
    final DateTime closedAt =
        DateTime.now().subtract(Duration(days: random.nextInt(365)));
    final DateTime openedAt =
        closedAt.subtract(Duration(hours: random.nextInt(5) + 1));
    data.add({
      "closed_at": closedAt.toIso8601String(),
      "country": countries[random.nextInt(countries.length)],
      "device_id": "device-${random.nextInt(10000)}",
      "duration": closedAt.difference(openedAt).inSeconds,
      "id": "id-${random.nextInt(100000)}",
      "opened_at": openedAt.toIso8601String(),
    });
  }

  data.sort((a, b) =>
      DateTime.parse(b["closed_at"]).compareTo(DateTime.parse(a["closed_at"])));

  return data;
}
