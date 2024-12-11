import 'package:flutter/material.dart';

import 'package:Helios/common/domain/app_settings_bloc/bloc.dart';

import 'package:Helios/repositories/repository_providers.dart';
import 'package:Helios/repositories/local_repository/init.dart';

import 'package:Helios/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  runApp(
    RepositoryProviders(
      child: AppSettingsBloc.appSettingsProvider(
        child: const App(),
      ),
    ),
  );
}
