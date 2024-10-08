import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/features/vpn_app/domain/vpn/enums/enums.dart';

import 'package:hive/hive.dart';

part 'vpn_status.g.dart';

@HiveType(typeId: 4)
class VPNStatus {
  VPNStatus({
    this.country,
    this.protocol,
    this.status = Status.disconnected,
    this.download,
    this.upload,
  });

  @HiveField(0)
  Country? country;

  @HiveField(1)
  Protocol? protocol;

  @HiveField(2)
  Status? status;

  int? download;
  int? upload;
}
