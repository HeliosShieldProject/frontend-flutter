
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MyTheme theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = AppTheme.of(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.theme!.colorScheme.background,
      body: Center(
        child: ElevatedButton(
          onPressed: () => changeTheme(context),
          style: theme.theme!.elevatedButtonTheme.style,
          child: Text("Press me!",
            style: theme.theme!.textTheme.displayMedium,
          )
        ),
      ),
    );
  }
}

