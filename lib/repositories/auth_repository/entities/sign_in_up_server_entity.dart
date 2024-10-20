import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

class SignInUpServerEntity implements BasicServerEntity {
  const SignInUpServerEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });

  const SignInUpServerEntity.error({required this.status})
      : accessToken = null,
        refreshToken = null;

  final String? accessToken;
  final String? refreshToken;

  @override
  final Auth status;
}
