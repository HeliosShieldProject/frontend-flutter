import 'package:Helios/features/register_sign_in/domain/services/server/mappers/sign_in_server_entity_mapper.dart';
import 'package:dio/dio.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/server/response.dart';
import 'package:Helios/common/server/dio.dart';

Future<BasicServerEntity> serverSignUp({required User user}) async {
  final result = await dio.request(
    "/auth/sign-up",
    data: user.toJson(),
    options: Options(
      method: "POST",
    ),
  );

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
