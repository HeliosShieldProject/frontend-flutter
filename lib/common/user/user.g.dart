// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserImplAdapter extends TypeAdapter<UserImpl> {
  @override
  final int typeId = 3;

  @override
  UserImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserImpl()
      ..name = fields[0] as String?
      ..password = fields[1] as String?
      ..email = fields[2] as String?
      ..deviceName = fields[3] as String?
      ..deviceType = fields[4] as String?
      ..jwtRefreshToken = fields[5] as String?
      ..jwtToken = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, UserImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.deviceName)
      ..writeByte(4)
      ..write(obj.deviceType)
      ..writeByte(5)
      ..write(obj.jwtRefreshToken)
      ..writeByte(6)
      ..write(obj.jwtToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
