import 'package:Helios/common/enums/enums.dart';

abstract interface class BasicServerEntity {
  BasicServerEntity(this.status);

  final Auth status;
}
