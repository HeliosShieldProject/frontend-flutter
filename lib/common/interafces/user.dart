import 'package:Helios/common/enums/enums.dart';

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
