// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProtocolAdapter extends TypeAdapter<Protocol> {
  @override
  final int typeId = 5;

  @override
  Protocol read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Protocol.vless;
      case 1:
        return Protocol.shadowsocks;
      default:
        return Protocol.vless;
    }
  }

  @override
  void write(BinaryWriter writer, Protocol obj) {
    switch (obj) {
      case Protocol.vless:
        writer.writeByte(0);
        break;
      case Protocol.shadowsocks:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProtocolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 6;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.connected;
      case 1:
        return Status.disconnected;
      case 2:
        return Status.restoring;
      default:
        return Status.connected;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.connected:
        writer.writeByte(0);
        break;
      case Status.disconnected:
        writer.writeByte(1);
        break;
      case Status.restoring:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
