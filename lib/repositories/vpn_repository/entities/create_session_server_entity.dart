import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/enums/enums.dart';

class CreateSessionServerEntity implements BasicServerEntity {
  const CreateSessionServerEntity({
    required this.sessionId,
    required this.status,
    required this.url,
  });

  const CreateSessionServerEntity.error({required this.status})
      : url = null,
        sessionId = null;

  final String? url;
  final String? sessionId;

  @override
  final Auth status;
}
