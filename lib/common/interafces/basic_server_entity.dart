import 'package:Helios/common/enums/enums.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract interface class BasicServerEntity {
  const BasicServerEntity(this.status);

  final Auth status;
}
