import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const AppUser(
          child: AppUserSettings(
              child: AppTheme(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
        ),
      )));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MyTheme theme;

  @override
  Widget build(BuildContext context) {
    theme = getTheme(AppUserSettings.of(context, listen: true)!.selectedTheme);

    return Scaffold(
      backgroundColor: theme.themeData.colorScheme.background,
      body: Center(
          child: DropdownMenu<SelectedTheme>(
        dropdownMenuEntries: SelectedTheme.values
            .map<DropdownMenuEntry<SelectedTheme>>(
                (SelectedTheme selectedTheme) {
          return DropdownMenuEntry<SelectedTheme>(
            value: selectedTheme,
            label: selectedTheme.name,
          );
        }).toList(),
        initialSelection: AppUserSettings.of(context)!.selectedTheme,
        onSelected: (value) => AppUserSettings.changeTheme(context, value!),
        textStyle: theme.themeData.textTheme.displayMedium,
      )),
    );
  }
}
