import 'package:flutter/material.dart';

import 'package:Helios/features/settings/domain/bloc/settings_bloc/settings_bloc.dart';

import 'package:Helios/repositories/repository_providers.dart';
import 'package:Helios/repositories/local_repository/close_hive.dart';
import 'package:Helios/repositories/local_repository/init.dart';

import 'package:Helios/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.addObserver(
    LifecycleEventHandler(
      detachedCallBack: closeHive,
    ),
  );

  await initHive();

  runApp(
    repositoryProviders(
      child: SettingsBloc.settingsProvider(
        child: const App(),
      ),
    ),
  );
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.detachedCallBack});

  final VoidCallback detachedCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        detachedCallBack();
        break;
      case AppLifecycleState.resumed:
      default:
    }
  }
}
