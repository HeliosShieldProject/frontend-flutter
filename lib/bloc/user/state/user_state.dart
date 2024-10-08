import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/user/user_impl.dart';
import 'package:Helios/common/enums/enums.dart';

abstract interface class UserState {
  UserState()
      : user = UserImpl(),
        status = Auth.failed;

  User user;
  Auth status;
}

class UserStateImpl implements UserState {
  UserStateImpl({
  });

  @override
  Auth status;

  @override
  User user;
  
}