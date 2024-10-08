import 'package:hive/hive.dart';

import 'package:Helios/repository/hive_keys.dart';

import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/user/user_impl.dart';

User getUser() {
  User user = UserImpl();

  try {
    final Box<User> userBox = Hive.box<User>(HiveKeys.userBox);
    user = userBox.get(HiveKeys.userKey, defaultValue: UserImpl())!;
  } catch (e) {
    return UserImpl();
  }

  return user;
}
