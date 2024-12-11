// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vpn_bloc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatesAdapter extends TypeAdapter<States> {
  @override
  final int typeId = 9;

  @override
  States read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return States.loading;
      case 1:
        return States.connected;
      case 2:
        return States.disconnected;
      case 3:
        return States.error;
      default:
        return States.loading;
    }
  }

  @override
  void write(BinaryWriter writer, States obj) {
    switch (obj) {
      case States.loading:
        writer.writeByte(0);
        break;
      case States.connected:
        writer.writeByte(1);
        break;
      case States.disconnected:
        writer.writeByte(2);
        break;
      case States.error:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
