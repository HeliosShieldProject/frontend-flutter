import 'package:flutter/material.dart';

import 'package:Helios/common/navigation/routes.dart';

import 'package:Helios/common/theme/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context, listen: true),
        onGenerateRoute: RoutesBuilder.onGenerateRoute,
        onUnknownRoute: RoutesBuilder.onUnknownRoute,
        initialRoute: RouteNames.welcome,
      );
}
