part of '../models/vpn_connection.dart';

class VpnConnectionAdapter extends TypeAdapter<VpnConnection> {
  @override
  final int typeId = 4;

  @override
  VpnConnection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnConnection(
      country: fields[0] as Country,
      ip: fields[1] as IP,
      protocol: fields[2] as Protocols,
      shareLink: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VpnConnection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.ip)
      ..writeByte(2)
      ..write(obj.protocol)
      ..writeByte(3)
      ..write(obj.shareLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnConnectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
