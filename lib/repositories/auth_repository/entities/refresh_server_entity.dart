import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

class RefreshServerEntity implements BasicServerEntity {
  RefreshServerEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });

  const RefreshServerEntity.error({required this.status})
      : accessToken = null,
        refreshToken = null;

  final String? accessToken;
  final String? refreshToken;

  @override
  final Auth status;
}
