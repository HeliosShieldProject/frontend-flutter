// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../common/user/user_impl.dart';

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
    return UserImpl(
      email: fields[0] as String?,
      jwtRefreshToken: fields[1] as String?,
      jwtToken: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.jwtRefreshToken)
      ..writeByte(2)
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
