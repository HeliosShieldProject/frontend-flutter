import 'package:flutter/material.dart';
import 'package:helios/app/app.dart';
import 'package:helios/common/common.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive
    ..registerAdapter(UserSettingsImplAdapter())
    ..registerAdapter(UserImplAdapter())
    ..registerAdapter(SubscriptionTypeAdapter())
    ..registerAdapter(SelectedThemeAdapter());

  runApp(
    const AppUser(
      child: AppUserSettings(
        child: AppTheme(
          child: App(),
        ),
      ),
    ),
  );
}
