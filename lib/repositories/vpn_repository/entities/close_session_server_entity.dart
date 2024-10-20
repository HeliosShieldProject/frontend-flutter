import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

class CloseSessionServerEntity implements BasicServerEntity {
  const CloseSessionServerEntity({
    required this.message,
    required this.status,
  });

  const CloseSessionServerEntity.error({required this.status}) : message = null;

  final String? message;

  @override
  final Auth status;
}
