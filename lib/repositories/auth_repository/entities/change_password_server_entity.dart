import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

class ChangePasswordServerEntity implements BasicServerEntity {
  const ChangePasswordServerEntity({
    required this.status,
  });

  @override
  final Auth status;
}
