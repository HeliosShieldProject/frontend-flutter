import 'package:flutter/material.dart';
import "package:hive/hive.dart";
import "package:jwt_decoder/jwt_decoder.dart";
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';

part '../../repositories/local_repository/user/generated/user_impl.g.dart';

@HiveType(typeId: 3)
@immutable
class UserImpl implements User {
  UserImpl({
    String? name,
    this.password = "unknwon",
    this.email = "test@mail.com",
    this.deviceName = "unknown",
    this.deviceType = "unknown",
    this.jwtRefreshToken = "unknwon",
    this.jwtToken = "unknwon",
  }) : name = name ?? email!.split("@")[0];

  @override
  final String? name;
  @override
  final String? password;
  @HiveField(0)
  @override
  final String? email;

  @override
  final String? deviceName;
  @override
  final String? deviceType;

  @HiveField(1)
  @override
  final String? jwtRefreshToken;
  @HiveField(2)
  @override
  final String? jwtToken;

  const UserImpl.empty()
      : name = null,
        email = null,
        password = null,
        deviceName = null,
        deviceType = null,
        jwtRefreshToken = null,
        jwtToken = null;

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
  User copyWith({
    String? name,
    String? email,
    String? password,
    String? deviceName,
    String? deviceType,
    String? jwtToken,
    String? jwtRefreshToken,
  }) {
    return UserImpl(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      deviceType: deviceType ?? this.deviceType,
      deviceName: deviceName ?? this.deviceName,
      jwtToken: jwtToken ?? this.jwtToken,
      jwtRefreshToken: jwtRefreshToken ?? this.jwtRefreshToken,
    );
  }

  @override
  UserValidity get validity {
    if (jwtToken == null || jwtRefreshToken == null) {
      return UserValidity.notValid;
    } else if (JwtDecoder.isExpired(jwtRefreshToken!)) {
      return UserValidity.notValid;
    }
    return UserValidity.needsRefreshment;
  }

  @override
  List<Object?> get props => [
        name,
        password,
        email,
        deviceName,
        deviceType,
        jwtRefreshToken,
        jwtToken
      ];

  @override
  bool? get stringify => true;
}
