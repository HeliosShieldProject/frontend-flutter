import 'package:flutter/material.dart';
import 'package:Helios/app/app.dart';
import 'package:Helios/common/common.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user.dart';

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
