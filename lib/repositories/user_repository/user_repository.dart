import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/user/user_impl.dart';
import 'package:Helios/repositories/local_repository/user/get_user.dart';
import 'package:Helios/repository/user/put_user.dart';

class UserRepository {
  User? _user;

  User getUser() {
    if (_user != null) {
      return _user!;
    }
    _user = getLocalUser();
    return _user!;
  }

  bool putUser() {
    return putLocalUser(
      user: _user ?? const UserImpl.empty(),
    );
  }
}
