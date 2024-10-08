import 'package:Helios/common/enums/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract interface class User extends Equatable {
  const User({
    this.name,
    this.password,
    this.email,
    this.deviceName,
    this.deviceType,
    this.jwtRefreshToken,
    this.jwtToken,
  });

  final String? name;
  final String? email;
  final String? password;

  final String? deviceName;
  final String? deviceType;

  final String? jwtToken;
  final String? jwtRefreshToken;

  Map<String, dynamic> toJson();

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? deviceName,
    String? deviceType,
    String? jwtToken,
    String? jwtRefreshToken,
  });

  UserValidity get validity;
}
