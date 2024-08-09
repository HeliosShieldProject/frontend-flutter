import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

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
          onTap: () {},
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
          onTap: () {},
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
          onTap: () {},
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
              HeliosListTile(children: <Widget>[
                SizedBox(
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.auto_fix_high_rounded,
                                size: 20,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Внешний вид",
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
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              RouteNames.appearance,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
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
                SizedBox(
                  height: 40,
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
                )
              ]),
            ],
          ),
        ),
      );
}

class HeliosListTile extends StatelessWidget {
  const HeliosListTile({
    super.key,
    this.titleWidget,
    required this.children,
  });

  final Widget? titleWidget;
  final List<Widget> children;

  List<Widget> effectiveChildren(BuildContext context) {
    var _children = <Widget>[];
    titleWidget != null
        ? _children.addAll(<Widget>[
            titleWidget!,
            const SizedBox(
              height: 20,
            ),
          ])
        : null;
    for (int i = 0; i < children.length; i++) {
      i == 0
          ? _children.add(children[i])
          : _children.addAll(
              <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 0,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                children[i],
              ],
            );
    }
    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: effectiveChildren(context),
      ),
    );
  }
}
