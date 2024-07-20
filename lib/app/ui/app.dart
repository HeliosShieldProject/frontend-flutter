
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
    bool isHiveBoxOpen = AppUserSettings.isBoxOpen(context, listen: true) && AppUser.isBoxOpen(context, listen: true);
    if(isHiveBoxOpen) {
      User appUser = AppUser.of(context)!;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.of(context)
          .pushReplacement(
            MaterialPageRoute(
              builder: (context) => 
                appUser.isValid() == UserValidity.isValid 
                ? 
                const HomeScreen() 
                : 
                const WelcomeScreen()
            )  
          )
      );
    }
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            CircularProgressIndicator.adaptive(),
          ],  
        ),
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

  @override
  Widget build(BuildContext context) {
    theme = getTheme(AppUserSettings.of(context, listen: true)!.selectedTheme);

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
          initialSelection: AppUserSettings.of(context)!.selectedTheme,
          onSelected: (value) => AppUserSettings.changeTheme(context, value!),
          textStyle: theme.themeData.textTheme.displayMedium,
        )
      ),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
