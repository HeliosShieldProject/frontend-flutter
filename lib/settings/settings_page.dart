import 'package:flutter/material.dart';
import 'package:Helios/common/common.dart';
import 'elements/elements.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget effectiveSubButton(BuildContext context) {
    return switch (AppUserSettings.of(context).subscriptionType) {
      SubscriptionType.free => HeliosButton(
          labelWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Обновитесь до Premium",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          color: Theme.of(context).colorScheme.onBackground,
          onTap: () => Navigator.pushNamed(
            context,
            RouteNames.subscription,
          ),
        ),
      SubscriptionType.premium => HeliosButton(
          labelWidget: Row(
            children: [
              Text(
                "Premium",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "1/2",
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
            stops: const <double>[
              0.3,
              0.7,
            ],
          ),
          onTap: () => Navigator.pushNamed(
            context,
            RouteNames.subscription,
          ),
        ),
      SubscriptionType.superPremium => HeliosButton(
          labelWidget: Row(
            children: [
              Text(
                "Super Premium",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                "2/2",
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ],
              stops: const <double>[
                0.3,
                0.7,
              ]),
          onTap: () => Navigator.pushNamed(
            context,
            RouteNames.subscription,
          ),
        ),
      null => throw UnimplementedError(),
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            "Параметры",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              effectiveSubButton(context),
              const SizedBox(
                height: 10,
              ),
              HeliosListTile(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      HeliosThemeButton(theme: SelectedTheme.values[2]),
                      Expanded(
                        child: Container(),
                      ),
                      HeliosThemeButton(theme: SelectedTheme.values[1]),
                      Expanded(
                        child: Container(),
                      ),
                      HeliosThemeButton(theme: SelectedTheme.values[0]),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              HeliosListTile(
                titleWidget: Row(
                  children: <Widget>[
                    Text(
                      "Аккаунт",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.menu_rounded,
                      size: 17,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.email_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          AppUser.of(context)!.email ?? "placeholder@email.com",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.password,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                color: Colors.white.withOpacity(0.5),
                                size: 20,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Сменить пароль",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white.withOpacity(0.5),
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          color: Colors.red.shade400,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Выйти",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.red.shade400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              HeliosListTile(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.history,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.public,
                                color: Colors.white.withOpacity(0.5),
                                size: 20,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "История",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white.withOpacity(0.5),
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.accessible_forward_rounded,
                                color: Colors.white.withOpacity(0.5),
                                size: 23,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Поддержка",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white.withOpacity(0.5),
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
