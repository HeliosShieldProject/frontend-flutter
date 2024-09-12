import "package:hive/hive.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';

part 'user_impl.g.dart';

@HiveType(typeId: 3)
class UserImpl implements User {
  @override
  String? name;
  @override
  String? password;
  @HiveField(0)
  @override
  String? email;

  @override
  String? deviceName;
  @override
  String? deviceType;

  @HiveField(1)
  @override
  String? jwtRefreshToken;
  @HiveField(2)
  @override
  String? jwtToken;

  UserImpl();

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "email": email,
        "password": password,
        "device": {
          "name": deviceName,
          "os": deviceType,
        }
      };

  @override
  UserValidity get validity {
    if (jwtToken == null || jwtRefreshToken == null) {
      return UserValidity.notValid;
    } else if (JwtDecoder.isExpired(jwtRefreshToken!)) {
      return UserValidity.notValid;
    }
    return UserValidity.needsRefreshment;
  }
}
