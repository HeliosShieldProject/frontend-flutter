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

class SubscriptionTypeAdapter extends TypeAdapter<SubscriptionType> {
  @override
  final int typeId = 1;

  @override
  SubscriptionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SubscriptionType.free;
      case 1:
        return SubscriptionType.premium;
      case 2:
        return SubscriptionType.superPremium;
      default:
        return SubscriptionType.free;
    }
  }

  @override
  void write(BinaryWriter writer, SubscriptionType obj) {
    switch (obj) {
      case SubscriptionType.free:
        writer.writeByte(0);
        break;
      case SubscriptionType.premium:
        writer.writeByte(1);
        break;
      case SubscriptionType.superPremium:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SelectedThemeAdapter extends TypeAdapter<SelectedTheme> {
  @override
  final int typeId = 2;

  @override
  SelectedTheme read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SelectedTheme.system;
      case 1:
        return SelectedTheme.dark;
      case 2:
        return SelectedTheme.light;
      default:
        return SelectedTheme.system;
    }
  }

  @override
  void write(BinaryWriter writer, SelectedTheme obj) {
    switch (obj) {
      case SelectedTheme.system:
        writer.writeByte(0);
        break;
      case SelectedTheme.dark:
        writer.writeByte(1);
        break;
      case SelectedTheme.light:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
