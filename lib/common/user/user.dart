import "package:hive/hive.dart";
import "package:jwt_decoder/jwt_decoder.dart";

part 'user.g.dart';

abstract interface class User {
  String? name;
  String? email;
  String? password;

  String? deviceName;
  String? deviceType;

  String? jwtToken;
  String? jwtRefreshToken;

  User();

  Map<String, dynamic> toJson();

  UserValidity get validity;
}

@HiveType(typeId: 3)
class UserImpl implements User {
  @HiveField(0)
  @override
  String? name;
  @HiveField(1)
  @override
  String? password;
  @HiveField(2)
  @override
  String? email;

  @HiveField(3)
  @override
  String? deviceName;
  @HiveField(4)
  @override
  String? deviceType;

  @HiveField(5)
  @override
  String? jwtRefreshToken;
  @HiveField(6)
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

enum UserValidity {
  needsRefreshment,
  notValid,
}
