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

  UserValidity isValid();
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
    "email" : email,
    "password" : password,
    "device" : {
      "name" : deviceName,
      "type" : deviceType,
    }
  };

  @override
  UserValidity isValid() {
    if (jwtToken != null && jwtRefreshToken != null) {
      if (JwtDecoder.isExpired(jwtToken!)) {
        return !JwtDecoder.isExpired(jwtRefreshToken!) ? UserValidity.needsRefreshment : UserValidity.notValid;  
      }
      return UserValidity.isValid;
    }
    return UserValidity.notValid;
  }

}

enum UserValidity {
  isValid,
  needsRefreshment,
  notValid,
}