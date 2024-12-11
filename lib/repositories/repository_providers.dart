import 'package:Helios/repositories/vpn_connection_repository/vpn_connection_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:Helios/repositories/user_settings_repository/user_settings_repository.dart';

class RepositoryProviders extends StatefulWidget {
  const RepositoryProviders({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<RepositoryProviders> createState() => _RepositoryProvidersState();
}

class _RepositoryProvidersState extends State<RepositoryProviders> {
  late final UserSettingsRepository _userSettingsRepository;

  @override
  void initState() {
    super.initState();

    _userSettingsRepository = UserSettingsRepository();
  }

  @override
  void dispose() {
    _userSettingsRepository.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: <RepositoryProvider>[
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider<UserSettingsRepository>(
            create: (context) => UserSettingsRepository()..init(),
          ),
          RepositoryProvider<VpnConnectionRepository>(
            create: (context) => VpnConnectionRepository(),
          ),
        ],
        child: widget.child,
      );
}
