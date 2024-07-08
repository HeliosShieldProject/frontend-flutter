import "package:jwt_decoder/jwt_decoder.dart";

abstract interface class User {
  String? name;
  String? email;
  String? password;
  String? deviceName;
  String? deviceType;
  String? jwtToken;
  String? jwtRefreshToken;
  SubscriptionType? subscriptionType;

  User();

  Map<String, dynamic> toJson();

  UserValidity isValid();
}

class UserImpl implements User {
  @override
  String? name;
  @override
  String? password;
  @override
  String? email;
  
  @override
  String? deviceName;
  @override
  String? deviceType;

  @override
  String? jwtRefreshToken;
  @override
  String? jwtToken;

  @override
  SubscriptionType? subscriptionType = SubscriptionType.free;

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

enum SubscriptionType {
  free, 
  premium,
  superPremium, 
}

enum UserValidity {
  isValid,
  needsRefreshment,
  notValid,
}