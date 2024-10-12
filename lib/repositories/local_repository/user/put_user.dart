import 'package:hive/hive.dart';

import 'package:Helios/repositories/local_repository/hive_keys.dart';

import 'package:Helios/common/interafces/user.dart';

bool putLocalUser({required User user}) {
  try {
    final Box<User> userBox = Hive.box<User>(HiveKeys.userBox);
    userBox.put(HiveKeys.userKey, user);
  } catch (e) {
    return false;
  }

  return true;
}
