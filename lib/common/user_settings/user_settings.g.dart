// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsImplAdapter extends TypeAdapter<UserSettingsImpl> {
  @override
  final int typeId = 0;

  @override
  UserSettingsImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsImpl()
      ..selectedTheme = fields[0] as SelectedTheme?
      ..subscriptionType = fields[1] as SubscriptionType?;
  }

  @override
  void write(BinaryWriter writer, UserSettingsImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.selectedTheme)
      ..writeByte(1)
      ..write(obj.subscriptionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
