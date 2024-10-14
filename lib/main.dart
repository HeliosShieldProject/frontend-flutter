import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/repositories/repository_providers.dart';

import 'package:Helios/app/app.dart';

void main() {
  runApp(
    repositoryProviders(
      child: const App(),
    ),
  );
}

MultiBlocProvider blocProviders({required Widget child}) => MultiBlocProvider(
      providers: <BlocProvider>[],
      child: child,
    );
