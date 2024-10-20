import 'package:hive/hive.dart';

import 'package:Helios/repositories/local_repository/hive_keys.dart';

import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/user/user_impl.dart';

User getLocalUser() {
  late final User user;

  try {
    final Box<User> userBox = Hive.box<User>(HiveKeys.userBox);
    user = userBox.get(HiveKeys.userKey, defaultValue: const UserImpl.empty())!;
  } catch (e) {
    return user;
  }

  return user;
}
