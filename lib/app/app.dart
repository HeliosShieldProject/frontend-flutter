import 'package:Helios/common/domain/app_settings_bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/common/theme/theme.dart';

import 'package:Helios/common/navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  bool _buildWhen(AppSettingsState oldState, AppSettingsState newState) {
    return oldState.themeMode != newState.themeMode;
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: state.themeMode,
            onGenerateRoute: RoutesBuilder.onGenerateRoute,
            onUnknownRoute: RoutesBuilder.onUnknownRoute,
            initialRoute: RouteNames.welcome,
          );
        },
        buildWhen: _buildWhen,
      );
}
