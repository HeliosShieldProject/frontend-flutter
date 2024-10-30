import 'package:Helios/common/interafces/basic_server_entity.dart';

import 'package:Helios/common/enums/enums.dart';

class CreateSessionServerEntity implements BasicServerEntity {
  const CreateSessionServerEntity({
    required this.sessionId,
    required this.status,
    required this.link,
  });

  const CreateSessionServerEntity.error({required this.status})
      : link = null,
        sessionId = null;

  final String? link;
  final String? sessionId;

  @override
  final Auth status;
}
