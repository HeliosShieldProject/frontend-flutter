import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helios/app/app.dart';
import 'package:helios/common/common.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await _initHive();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));

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
