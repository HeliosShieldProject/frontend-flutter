import 'package:flutter/material.dart';

import 'package:Helios/repositories/repository_providers.dart';

import 'package:Helios/app/app.dart';

void main() {
  runApp(
    repositoryProviders(
      child: const App(),
    ),
  );

  print("Hui");
}
