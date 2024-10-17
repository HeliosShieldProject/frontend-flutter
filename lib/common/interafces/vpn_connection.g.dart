// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_connection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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

class IPAdapter extends TypeAdapter<IP> {
  @override
  final int typeId = 5;

  @override
  IP read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IP(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IP obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstByte)
      ..writeByte(1)
      ..write(obj.secondByte)
      ..writeByte(2)
      ..write(obj.thirdByte)
      ..writeByte(3)
      ..write(obj.fourthByte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IPAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProtocolsAdapter extends TypeAdapter<Protocols> {
  @override
  final int typeId = 7;

  @override
  Protocols read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Protocols.vless;
      case 1:
        return Protocols.ss;
      default:
        return Protocols.vless;
    }
  }

  @override
  void write(BinaryWriter writer, Protocols obj) {
    switch (obj) {
      case Protocols.vless:
        writer.writeByte(0);
        break;
      case Protocols.ss:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProtocolsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
