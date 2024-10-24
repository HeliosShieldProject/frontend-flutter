import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part "server.dart";

class AppServer {
  static Future<SignInStatus> signIn(BuildContext context,
      {required String email, required String password}) async {
    User user = await _createUser(email: email, password: password);

    final Map<String, dynamic> response;

    try {
      response = await Server.signIn(
        user: user,
      );
    } catch (e) {
      print(e);
      return SignInStatus.failed;
    }

    if (response["data"] is SignInStatus) {
      return response["data"];
    } else {
      if (context.mounted) {
        AppUser.update(
          context,
          user
            ..jwtToken = response["data"]["access_token"]
            ..jwtRefreshToken = response["data"]["refresh_token"],
        );
        return SignInStatus.success;
      }
      return SignInStatus.failed;
    }
  }

  static Future<SignUpStatus> signUp(BuildContext context,
      {required String email, required String password}) async {
    User user = await _createUser(email: email, password: password);

    final Map<String, dynamic> response;

    try {
      response = await Server.signUp(
        user: user,
      );
    } catch (e) {
      print(e);
      return SignUpStatus.failed;
    }

    if (response["data"] is SignUpStatus) {
      return response["data"];
    } else {
      if (context.mounted) {
        AppUser.update(
          context,
          user
            ..jwtToken = response["data"]["access_token"]
            ..jwtRefreshToken = response["data"]["refresh_token"],
        );
        return SignUpStatus.success;
      }
      return SignUpStatus.failed;
    }
  }

  static Future<User> _createUser(
      {required String email, required String password}) async {
    final device = await DeviceInfoPlugin().deviceInfo;

    return UserImpl()
      ..name = email.split("@")[0]
      ..email = email
      ..password = password
      ..deviceType = switch (device) {
        (IosDeviceInfo _) => "Ios",
        (AndroidDeviceInfo _) => "Android",
        (WindowsDeviceInfo _) => "Windows",
        (LinuxDeviceInfo _) => "Linux",
        (MacOsDeviceInfo _) => "MacOs",
        BaseDeviceInfo() => "Unknown",
      }
      ..deviceName = switch (device) {
        (IosDeviceInfo deviceInfo) => deviceInfo.name,
        (AndroidDeviceInfo deviceInfo) => deviceInfo.model,
        (WindowsDeviceInfo deviceInfo) => deviceInfo.computerName,
        (LinuxDeviceInfo deviceInfo) => deviceInfo.prettyName,
        (MacOsDeviceInfo deviceInfo) => deviceInfo.computerName,
        BaseDeviceInfo() => "Unknown",
      };
  }

  static Future<RefreshStatus> refresh(BuildContext context) async {
    User user = AppUser.of(context)!;

    final Map<String, dynamic> response;

    try {
      response = await Server.refresh(
        user: user,
      );
    } catch (e) {
      return RefreshStatus.failed;
    }

    if (response["data"] is RefreshStatus) {
      return response["data"];
    } else if (context.mounted) {
      AppUser.update(
        context,
        user
          ..jwtToken = response["data"]["access_token"]
          ..jwtRefreshToken = response["data"]["refresh_token"],
      );
      return RefreshStatus.success;
    }
    return RefreshStatus.failed;
  }
}
