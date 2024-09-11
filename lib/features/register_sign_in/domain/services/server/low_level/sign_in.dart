import 'package:Helios/common/server/response.dart';
import 'package:Helios/features/register_sign_in/domain/services/server/mappers/sign_in_server_entity_mapper.dart';
import 'package:dio/dio.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/server/dio.dart';

Future<BasicServerEntity> serverSignIn({required User user}) async {
  final result = await dio.request(
    "/auth/sign-in",
    data: user.toJson(),
    options: Options(
      method: "POST",
    ),
  );

  BasicResponse response = switch (result.statusCode) {
    200 => responseMapper(
        json: result.data,
      ),
    int() || null => errorResponseMapper(
        json: result.data,
      ),
  };

  return signInUpServerEntityMapper(
    response: response,
  );
}
