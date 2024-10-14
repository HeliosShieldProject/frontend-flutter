import 'package:Helios/common/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        onGenerateRoute: RoutesBuilder.onGenerateRoute,
        onUnknownRoute: RoutesBuilder.onUnknownRoute,
        initialRoute: RouteNames.welcome,
      );
}
