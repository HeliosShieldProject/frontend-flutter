import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/basic_server_entity.dart';

class SignOutServerEntity implements BasicServerEntity {
  const SignOutServerEntity({required this.status});

  @override
  final Auth status;
}
