import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.of(context, listen: true).themeData,
        onGenerateRoute: RoutesBuilder.onGenerateRoute,
        onUnknownRoute: RoutesBuilder.onUnknownRoute,
        initialRoute: RouteNames.welcome,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: HeliosIcon(
              radius: MediaQuery.of(context).size.width * 0.306,
              showHelios: true,
            ),
          ),
          Center(
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
            textStyle: Theme.of(context).textTheme.displayMedium,
          )),
        ],
      ),
    );
  }
}
