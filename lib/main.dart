import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:Helios/common/theme/theme_provider.dart';
import 'package:Helios/common/user/user_provider.dart';
import 'package:Helios/common/user_settings/user_settings_provider.dart';

import 'package:Helios/repository/init_repository.dart';

import 'package:Helios/app/app.dart';

Future<void> main() async {
  await initHive();

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
