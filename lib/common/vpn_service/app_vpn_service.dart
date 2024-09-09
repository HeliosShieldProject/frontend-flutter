import 'package:flutter/material.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

class AppVPNService {
  static ValueNotifier<V2RayStatus> status =
      ValueNotifier<V2RayStatus>(V2RayStatus());

  static final FlutterV2ray _flutterV2ray = FlutterV2ray(
    onStatusChanged: (v2RayStatus) {
      status.value = v2RayStatus;
    },
  );

  static Future<bool> connect({required String url}) async {
    await _flutterV2ray.initializeV2Ray();

    final V2RayURL config = FlutterV2ray.parseFromURL(url);

    if (status.value.state != "CONNECTED" &&
        await _flutterV2ray.requestPermission()) {
      await _flutterV2ray.startV2Ray(
        remark: config.remark,
        config: config.getFullConfiguration(),
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<void> disconnectCurrent() async {
    await _flutterV2ray.stopV2Ray();
  }

  static Future<int> checkServerDelay({required String url}) async {
    return await _flutterV2ray.getServerDelay(
      config: FlutterV2ray.parseFromURL(url).fullConfiguration.toString(),
    );
  }
}
