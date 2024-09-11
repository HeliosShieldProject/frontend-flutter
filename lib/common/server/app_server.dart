import 'package:flutter/material.dart';
import 'package:Helios/common/common.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part "server.dart";


Future<User> _createUser(
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

class AppServer {
  static 

  static

  static 

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

  static Future<CreateSessionStatus> createSession(BuildContext context,
      {required String country}) async {
    User user = AppUser.of(context)!;

    final Map<String, dynamic> response;

    try {
      response = await Server.createSession(
        country: country,
        user: user,
      );
    } catch (e) {
      return CreateSessionStatus.failed;
    }

    if (response["data"] is CreateSessionStatus) {
      return response["data"];
    } else {
      return response["data"];
    }
  }
}
