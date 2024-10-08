import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/features/vpn_app/domain/vpn/enums/enums.dart';
import 'package:flutter_v2ray/model/v2ray_status.dart';
import 'package:Helios/features/vpn_app/domain/vpn/models/vpn_status.dart';

VPNStatus vpnStatusMapper(
        {required V2RayStatus v2rayStatus,
        Country? country,
        Protocol? protocol}) =>
    VPNStatus(
        country: country,
        protocol: protocol,
        status: switch (v2rayStatus.state) {
          "CONNECTED" => Status.connected,
          "DISCONNECTED" => Status.disconnected,
          String() => Status.disconnected,
        },
        download: v2rayStatus.download,
        upload: v2rayStatus.upload);
