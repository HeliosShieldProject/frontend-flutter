import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/interfaces.dart';

import 'package:Helios/repositories/session_repository/entities/create_session_server_entity.dart';
import 'package:Helios/repositories/session_repository/low_level/create_session.dart';

Future<String> createSession(
    {required User user,
    required Country country,
    required Protocols protocol}) async {
  final BasicServerEntity response;

  try {
    response = await serverCreateSession(
      accessToken: user.jwtToken!,
      country: country.countryName,
      protocol: protocol.name,
    );
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }

  response as CreateSessionServerEntity;
  return response.link!;
}
