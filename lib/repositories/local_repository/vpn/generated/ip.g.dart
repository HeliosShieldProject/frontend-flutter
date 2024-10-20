part of '../models/ip.dart';

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
