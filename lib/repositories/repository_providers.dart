import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';

MultiRepositoryProvider repositoryProviders({required Widget child}) =>
    MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<UserSettingsRepository>(
          create: (context) => UserSettingsRepository(),
        ),
        RepositoryProvider<VpnConnectionRepository>(
          create: (context) => VpnConnectionRepository(),
        ),
      ],
      child: child,
    );
