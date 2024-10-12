import 'package:flutter/widgets.dart';

import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

MultiRepositoryProvider repositoryProviders({required Widget child}) =>
    MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserSettingsRepository(),
        ),
      ],
      child: child,
    );