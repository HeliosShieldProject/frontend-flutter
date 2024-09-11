import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/server/response.dart';

class SignInUpServerEntity implements BasicServerEntity {
  SignInUpServerEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });

  final String? accessToken;
  final String? refreshToken;

  @override
  final Auth status;
}
