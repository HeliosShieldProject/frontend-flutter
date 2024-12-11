import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/auth_repository/low_level/sign_out.dart';

Future<bool> signOut({required User user}) async {
  final BasicServerEntity response;

  try {
    response = await serverSignOut(
      accessToken: user.jwtToken!,
    );
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }

  return true;
}
