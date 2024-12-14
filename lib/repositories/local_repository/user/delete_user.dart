import 'package:hive/hive.dart';

import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/local_repository/hive_keys.dart';

Future<void> deletLocalUser() async {
  await Hive.box<User>(HiveKeys.userBox).clear();
}
