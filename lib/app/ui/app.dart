
import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
    AppTheme(
      theme: lightTheme,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyTheme theme = AppTheme.of(context, listen: true);
    
    return Scaffold(
      backgroundColor: theme.theme?.colorScheme.background,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (theme.isLight ?? false) {
              AppTheme.update(context, darkTheme);
            } else {
              AppTheme.update(context, lightTheme);
            }
          },
          style: theme.theme?.elevatedButtonTheme.style,
          child: Text("Press me!",
            style: theme.theme?.textTheme.displayMedium,
          )
        ),
      ),
    );
  }
}