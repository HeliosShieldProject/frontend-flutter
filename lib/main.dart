import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/repositories/local_repository/init.dart';
import 'package:Helios/repositories/repository_providers.dart';

import 'package:Helios/app/app.dart';

Future<void> main() async {
  await initHive();

  await dotenv.load(
    fileName: "master_backend.env",
  );

  runApp(
    repositoryProviders(
      child: blocProviders(
        child: const App(),
      ),
    ),
  );
}

MultiBlocProvider blocProviders({required Widget child}) => MultiBlocProvider(
      providers: <BlocProvider>[],
      child: child,
    );
