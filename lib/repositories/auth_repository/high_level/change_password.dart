import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';
import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/auth_repository/entities/change_password_server_entity.dart';
import 'package:Helios/repositories/auth_repository/low_level/change_password.dart';

Future<Auth> changePassword(
    {required User user, required String newPassword}) async {
  late final BasicServerEntity response;

  try {
    response = await serverChangePassword(
        accessToken: user.jwtToken!, newPassword: newPassword);
  } catch (e) {
    throw Auth.failed;
  }

  if (response.status != Auth.success) {
    throw response.status;
  }

  response as ChangePasswordServerEntity;
  return response.status;
}
