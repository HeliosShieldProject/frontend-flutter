import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/repositories/local_repository/user/user.dart';

class UserRepository {
  User? _user;

  User get() {
    if (_user != null) {
      return _user!;
    }
    _user = getLocalUser();
    return _user!;
  }

  bool put({required User user}) {
    _user = user;
    return putLocalUser(
      user: _user!,
    );
  }

  Future<void> delete() async {
    _user = null;
    await deletLocalUser();
  }
}
