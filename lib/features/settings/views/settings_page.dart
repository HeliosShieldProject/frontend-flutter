import 'package:Helios/features/register_sign_in/widgets/loading_icon.dart';
import 'package:Helios/features/register_sign_in/widgets/snackbar.dart';
import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';
import 'package:Helios/features/vpn_app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/navigation/routes.dart';
import 'package:Helios/common/constants/constants.dart';

import 'package:Helios/common/ui/elements/helios_button.dart';

import 'package:Helios/features/settings/widgets/widgets.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:Helios/features/settings/domain/bloc/settings_bloc/bloc.dart';
import 'package:Helios/features/vpn_app/widgets/helios_list_element.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool willPop = true;

  late ColorScheme colorScheme;
  late TextTheme textTheme;

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
        HeliosListElement(
          icon: Icons.logout_rounded,
          label: Literals.toLogOut,
          showArrow: false,
          color: Colors.red,
          onTap: _handleLogOut,
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
    final ThemeData value = Theme.of(context);

    final ColorScheme colorScheme = value.colorScheme;

    final TextStyle titleLarge = value.textTheme.titleLarge!.copyWith(
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
                Text("Premium", style: titleLarge),
                Text("1/2", style: titleLarge)
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[colorScheme.primary, colorScheme.secondary],
              stops: const <double>[0.3, 0.7],
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
                Text("Super Premium", style: titleLarge),
                Text("2/2", style: titleLarge)
              ],
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[colorScheme.primary, colorScheme.secondary],
              stops: const <double>[0.3, 0.7],
            ),
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.subscription,
            ),
          ),
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ThemeData theme = Theme.of(context);

    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;
  }

  void _onTapThemeButton(
    SettingsBloc bloc,
    SelectedTheme newTheme,
  ) {
    bloc.add(
      ChangeSelectedThemeEvent(selectedTheme: newTheme),
    );
  }

  void _onTapAppBar(BuildContext context) => Navigator.of(context).maybePop();

  void _handleLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CustomDialog(
        buttonLabel: Literals.toLogOut,
        dialogTitle: "Вы уверены, что хотите выйти?",
      ),
    ).then(
      (value) async {
        if (value != null && context.mounted) {
          final LoadingIcon loadingIcon = LoadingIcon()
            ..showLoadingIcon(context);

          setState(() {
            willPop = false;
          });

          final VpnBloc bloc = context.read<VpnBloc>();

          if (bloc.state.state == States.disconnected ||
              bloc.state.state == States.error) {
            await Future.delayed(const Duration(milliseconds: 1000));
          }

          loadingIcon.removeLoadingIcon();

          setState(() {
            willPop = true;
          });

          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar(context, title: Literals.failed));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: willPop,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: NumericConstants.iconSize,
                    color: colorScheme.onSurface,
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
                              NumericConstants.borderRadius,
                            ),
                          ),
                          padding: const EdgeInsets.all(
                            NumericConstants.horizontalPadding,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              HeliosThemeButton(
                                value: SelectedTheme.values[2],
                                groupValue: state.selectedTheme,
                                onChange: (newTheme) => _onTapThemeButton(
                                  context.read<SettingsBloc>(),
                                  newTheme,
                                ),
                              ),
                              HeliosThemeButton(
                                value: SelectedTheme.values[1],
                                groupValue: state.selectedTheme,
                                onChange: (newTheme) => _onTapThemeButton(
                                  context.read<SettingsBloc>(),
                                  newTheme,
                                ),
                              ),
                              HeliosThemeButton(
                                value: SelectedTheme.values[0],
                                groupValue: state.selectedTheme,
                                onChange: (newTheme) => _onTapThemeButton(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Аккаунт",
                                style: textTheme.titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Icon(
                                Icons.menu_rounded,
                                size: 15,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ],
                          ),
                          builder: HeliosListElement.builder,
                          children: _elements1(state.email),
                        ),
                        const BlankSpacer(),
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
        ),
      );
}
