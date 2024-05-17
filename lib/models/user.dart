import "package:flutter_riverpod/flutter_riverpod.dart";

final userProvider = Provider<User> (
  (ref) => User()
);

class User {
  String? email;
  String? password;
  String? deviceName;
  String? deviceType;
  String? token;
  String? refreshToken;

  User({this.email, this.password, this.deviceName, this.deviceType});

  factory User.fromJson(Map<String, dynamic> json) =>  User (
    email: json["email"],
    password: json["password"],
    deviceName: json["device"]["name"],
    deviceType: json["device"]["type"],
  );

  Map<String, dynamic> toJson() => {
    "email" : email,
    "password" : password,
    "device" : {
      "name" : deviceName,
      "type" : deviceType,
    }
  };
}
