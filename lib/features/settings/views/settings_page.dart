import 'package:Helios/common/interafces/user.dart';
import 'package:Helios/common/interafces/user_settings.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:Helios/features/settings/domain/bloc/settings_bloc/settings_bloc.dart';
import 'package:Helios/repositories/user_repository/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/navigation/routes.dart';
import 'package:Helios/common/constants/constants.dart';

import 'package:Helios/common/ui/elements/helios_button.dart';

import 'package:Helios/features/settings/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  Widget _effectiveSubButton(
      BuildContext context, SubscriptionType subscriptionType) {
    return switch (subscriptionType) {
      SubscriptionType.free => HeliosButton(
          label: "Обновитесь до Premium",
          color: Theme.of(context).colorScheme.onSurface,
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
    };
  }

  void _onTapAppBar(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    final UserSettings userSettings = context.read<SettingsBloc>().state;
    final User user = context.read<UserRepository>().get();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: NumericConstants.iconSize,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => _onTapAppBar(context),
        ),
        title: Text(
          Literals.settings,
          style: textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(
          top: NumericConstants.topPadding,
          left: NumericConstants.horizontalPadding,
          right: NumericConstants.horizontalPadding,
        ),
        child: Column(
          children: [
            _effectiveSubButton(
              context,
              userSettings.subscriptionType,
            ),
            const BlankSpacer(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HeliosThemeButton(theme: SelectedTheme.values[2]),
                  HeliosThemeButton(theme: SelectedTheme.values[1]),
                  HeliosThemeButton(theme: SelectedTheme.values[0]),
                ],
              ),
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
                        size: NumericConstants.iconSize,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "placeholder@email.com",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
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
                            size: NumericConstants.iconSize,
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
}
