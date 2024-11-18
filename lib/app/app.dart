import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/features/settings/domain/bloc/settings_bloc/settings_bloc.dart';

import 'package:Helios/common/theme/theme.dart';
import 'package:Helios/common/theme/utils/get_theme.dart';

import 'package:Helios/common/interafces/interfaces.dart';
import 'package:Helios/common/navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  bool _buildWhen(UserSettings oldSettings, UserSettings newSettings) =>
      oldSettings.selectedTheme != newSettings.selectedTheme;

  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, UserSettings>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: getThemeMode(state.selectedTheme),
            onGenerateRoute: RoutesBuilder.onGenerateRoute,
            onUnknownRoute: RoutesBuilder.onUnknownRoute,
            initialRoute: RouteNames.welcome,
          );
        },
        buildWhen: _buildWhen,
      );
}
