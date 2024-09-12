import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/user/user_impl.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<User> createUser(
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
