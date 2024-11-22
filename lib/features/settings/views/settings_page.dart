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

  List<HeliosListElement> _elements1(String email) => <HeliosListElement>[
        HeliosListElement(
          icon: Icons.email_rounded,
          label: email,
          showArrow: false,
        ),
        HeliosListElement(
          icon: Icons.lock_rounded,
          label: Literals.changePassword,
          onTap: (context) => Navigator.pushNamed(context, RouteNames.password),
        ),
        const HeliosListElement(
          icon: Icons.logout_rounded,
          label: Literals.toLogOut,
          showArrow: false,
          color: Colors.red,
        ),
      ];

  List<HeliosListElement> get _elements2 => <HeliosListElement>[
        HeliosListElement(
          icon: Icons.public_outlined,
          label: Literals.history,
          onTap: (context) => Navigator.pushNamed(context, RouteNames.history),
        ),
        const HeliosListElement(
          icon: Icons.accessible_forward_rounded,
          label: Literals.feedback,
        ),
      ];

  Widget _effectiveSubButton(
      BuildContext context, SubscriptionType subscriptionType) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;

    final TextStyle titleLarge = theme.textTheme.titleLarge!.copyWith(
      color: Colors.white,
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: NumericConstants.topPadding,
        left: NumericConstants.horizontalPadding,
        right: NumericConstants.horizontalPadding,
      ),
      child: switch (subscriptionType) {
        SubscriptionType.free => HeliosButton(
            label: "Обновитесь до Premium",
            color: colorScheme.onSurface,
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.subscription,
            ),
          ),
        SubscriptionType.premium => HeliosButton(
            labelWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Premium",
                  style: titleLarge,
                ),
                Text(
                  "1/2",
                  style: titleLarge,
                )
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                colorScheme.primary,
                colorScheme.secondary,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Super Premium",
                  style: titleLarge,
                ),
                Text(
                  "2/2",
                  style: titleLarge,
                )
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[colorScheme.primary, colorScheme.secondary],
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
      },
    );
  }

  void _onTapThemeButton(
    SettingsBloc bloc,
    SelectedTheme newTheme,
  ) {
    bloc.add(
      SettingsChangedThemeEvent(newTheme: newTheme),
    );
  }

  void _onTapAppBar(BuildContext context) => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    final User user = context.read<UserRepository>().get();

    return BlocBuilder<SettingsBloc, UserSettings>(
      builder: (context, state) {
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
              style: textTheme.titleLarge,
            ),
          ),
          body: Column(
            children: [
              _effectiveSubButton(
                context,
                state.subscriptionType,
              ),
              SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.only(
                  top: NumericConstants.spacerSize,
                  left: NumericConstants.horizontalPadding,
                  right: NumericConstants.horizontalPadding,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(
                            NumericConstants.borderRadius),
                      ),
                      padding: const EdgeInsets.all(
                          NumericConstants.horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HeliosThemeButton(
                            theme: SelectedTheme.values[2],
                            currentTheme: state.selectedTheme,
                            onTap: (newTheme) => _onTapThemeButton(
                              context.read<SettingsBloc>(),
                              newTheme,
                            ),
                          ),
                          HeliosThemeButton(
                            theme: SelectedTheme.values[1],
                            currentTheme: state.selectedTheme,
                            onTap: (newTheme) => _onTapThemeButton(
                              context.read<SettingsBloc>(),
                              newTheme,
                            ),
                          ),
                          HeliosThemeButton(
                            theme: SelectedTheme.values[0],
                            currentTheme: state.selectedTheme,
                            onTap: (newTheme) => _onTapThemeButton(
                              context.read<SettingsBloc>(),
                              newTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BlankSpacer(),
                    HeliosListTile<HeliosListElement>(
                      titleWidget: Row(
                        children: <Widget>[
                          Text(
                            "Аккаунт",
                            style: textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Icon(
                            Icons.menu_rounded,
                            size: 15,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ],
                      ),
                      builder: HeliosListElement.builder,
                      children:
                          _elements1(user.email ?? "placeholder@test.com"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HeliosListTile<HeliosListElement>(
                      builder: HeliosListElement.builder,
                      children: _elements2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeliosListElement {
  const HeliosListElement({
    required this.icon,
    required this.label,
    this.onTap,
    this.color = Colors.white,
    this.showArrow = true,
  });

  final IconData icon;
  final String label;
  final void Function(BuildContext context)? onTap;
  final Color color;
  final bool showArrow;

  List<Widget> _effectiveChildren(BuildContext context) {
    final List<Widget> result = <Widget>[
      Icon(
        icon,
        color: color.withOpacity(0.7),
        size: NumericConstants.listElementIconSize,
      ),
      const BlankSpacer(
        horizontal: true,
      ),
      Text(
        label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
      ),
    ];

    if (showArrow) {
      result.addAll(
        <Widget>[
          const Expanded(
            child: SizedBox(),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: color.withOpacity(0.5),
            size: NumericConstants.listElementIconSize,
          ),
        ],
      );
    }

    return result;
  }

  static Widget builder(BuildContext context, HeliosListElement element) =>
      SizedBox(
        height: NumericConstants.listElementHeight,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: element.onTap != null ? () => element.onTap!(context) : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: element._effectiveChildren(context),
            ),
          ),
        ),
      );
}
