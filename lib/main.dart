import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:Helios/common/theme/theme_provider.dart';
import 'package:Helios/common/user/user_provider.dart';
import 'package:Helios/common/user_settings/user_settings_provider.dart';

import 'package:Helios/common/user/user_impl.dart';
import 'package:Helios/common/user_settings/user_settings_impl.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/interfaces.dart';

import 'package:Helios/app/app.dart';

Future<void> main() async {
  await _initHive();

  await dotenv.load(
    fileName: "master_backend.env",
  );

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

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive
    ..registerAdapter(UserSettingsImplAdapter())
    ..registerAdapter(UserImplAdapter())
    ..registerAdapter(SubscriptionTypeAdapter())
    ..registerAdapter(SelectedThemeAdapter());

  await Hive.openBox<UserSettings>("UserSettings");
  await Hive.openBox<User>("User");
}
