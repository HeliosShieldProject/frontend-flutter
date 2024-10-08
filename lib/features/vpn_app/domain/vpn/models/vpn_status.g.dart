// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VPNStatusAdapter extends TypeAdapter<VPNStatus> {
  @override
  final int typeId = 4;

  @override
  VPNStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VPNStatus(
      country: fields[0] as Country?,
      protocol: fields[1] as Protocol?,
      status: fields[2] as Status?,
    );
  }

  @override
  void write(BinaryWriter writer, VPNStatus obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.country)
      ..writeByte(1)
      ..write(obj.protocol)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VPNStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
