import 'package:Helios/common/theme/theme.dart';
import 'package:Helios/repositories/local_repository/close_hive.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/navigation/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onDetach: closeHive,
    );
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        onGenerateRoute: RoutesBuilder.onGenerateRoute,
        onUnknownRoute: RoutesBuilder.onUnknownRoute,
        initialRoute: RouteNames.welcome,
      );
}
