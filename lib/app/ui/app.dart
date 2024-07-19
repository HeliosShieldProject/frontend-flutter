
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helios/common/common.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
    const AppUser( 
      child: AppUserSettings( 
        child: AppTheme(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
        )
      )
    );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSettingsBoxOpen = AppUserSettings.isBoxOpen(context, listen: true);
    if(isSettingsBoxOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: 
        (context) => const HomeScreen()
      )));
    }
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome",),
          CircularProgressIndicator.adaptive()
        ],  
      )
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MyTheme theme;

  @override void didChangeDependencies() {
    super.didChangeDependencies();
    theme = getTheme(AppUserSettings.of(context, listen: true)!.selectedTheme);
    print("HomeScreen didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: theme.themeData.colorScheme.background,
      body: Center(
        child: DropdownMenu<SelectedTheme>(
          dropdownMenuEntries: SelectedTheme.values.map<DropdownMenuEntry<SelectedTheme>>(
            (SelectedTheme selectedTheme) {
              return DropdownMenuEntry<SelectedTheme>(
                value: selectedTheme,
                label: selectedTheme.name,
              );
            }
          ).toList(),
          initialSelection: (AppUserSettings.of(context) ?? UserSettingsImpl()).selectedTheme,
          onSelected: (value) => AppUserSettings.changeTheme(context, value!),
        )
      ),
    );
  }
}

