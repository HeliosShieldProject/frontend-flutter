import 'package:Helios/common/interafces/country.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';

import 'package:Helios/common/constants/constants.dart';
import 'package:Helios/common/constants/countries_constants.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/navigation/routes.dart';

import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onTapAppBar(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteNames.settings,
    );
  }

  void _handleChange(BuildContext context, bool val) {
    final VpnBloc bloc = context.read<VpnBloc>();

    if (val) {
      bloc.add(VpnConnectionExecutedEvent());
    } else {
      bloc.add(VpnConnectionDisconnectedEvent());
    }
  }

  void _handleCardTap(BuildContext context) {
    showModalBottomSheet<(Country, Protocols)>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ServerSelector(),
    ).then(
      (value) {
        if (value != null && context.mounted) {
          final VpnBloc bloc = context.read<VpnBloc>();

          bloc.add(
            ChangeSelectedServerEvent(country: value.$1, protocol: value.$2),
          );
        }
      },
    );
  }

  void _blocListener(BuildContext context, VpnState state) {
    switch (state.state) {
      case States.error:
        state as ErrorVpnState;

        if (state.error case Auth _) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              dialogTitle: state.error.name,
              buttonLabel: Literals.dialogButton,
            ),
          );
        } else if (state.error case String _) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              dialogTitle: state.error,
              buttonLabel: Literals.dialogButton,
            ),
          );
        }
        break;
      default:
        print(state.state);
        break;
    }
  }

  bool _listenWhen(VpnState oldState, VpnState newState) =>
      (newState.state == States.error);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<VpnBloc, VpnState>(
      listener: _blocListener,
      listenWhen: _listenWhen,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: double.infinity,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: NumericConstants.horizontalPadding,
              ),
              child: SvgPicture.asset(
                fit: BoxFit.contain,
                "assets/images/helios_icon.svg",
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
                height: NumericConstants.iconSize,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: colorScheme.onSurface,
                  size: NumericConstants.iconSize + 5,
                ),
                onPressed: () => _onTapAppBar(context),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: NumericConstants.horizontalPadding,
              right: NumericConstants.horizontalPadding,
              bottom: NumericConstants.bottomPadding,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: HeliosConnectButton(
                      state: state.state ?? States.loading,
                      onChange: (val) => _handleChange(context, val),
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
                HeliosVpnCard(
                  connected: state.state == States.connected,
                  onTap: () => _handleCardTap(context),
                  protocol: state.protocol,
                  currentCountry: state.country,
                  uploadSpeed: state.uploadSpeed,
                  downloadSpeed: state.downloadSpeed,
                  countryIp: state.ip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServerSelector extends StatelessWidget {
  const ServerSelector({super.key});

  List<Widget> _getEffectiveChildren(BuildContext context) {
    List<Widget> result = <Widget>[];

    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    for (Country country in CountriesConstants.values) {
      for (Protocols protocol in Protocols.values) {
        result.addAll(
          <Widget>[
            SizedBox(
              height: NumericConstants.listElementHeight,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(
                    context,
                    (country, protocol),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CountryFlag.fromCountryCode(
                            country.countryCode,
                            shape: const Circle(),
                            height: 30,
                            width: 30,
                          ),
                          const BlankSpacer(
                            horizontal: true,
                          ),
                          Text(
                            country.countryName,
                            style: textTheme.titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: colorScheme.onTertiary,
                          ),
                          borderRadius: BorderRadius.circular(
                              NumericConstants.borderRadius),
                        ),
                        child: Text(
                          protocol.name,
                          style: textTheme.labelMedium!.copyWith(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 15.0 * Multipliers.heliosListTileDivider2BlankSpacer,
              child: Divider(
                color: colorScheme.onTertiary,
                height: 0.0,
                thickness: 2.0,
              ),
            ),
          ],
        );
      }
    }

    result.removeLast();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: NumericConstants.horizontalPadding,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.tertiary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(NumericConstants.borderRadius),
              topRight: Radius.circular(NumericConstants.borderRadius),
            ),
          ),
          padding: const EdgeInsets.all(NumericConstants.horizontalPadding),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Доступные подключения",
                  style: textTheme.labelMedium!.copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const BlankSpacer(
                multiplier: 3.5,
              ),
              ..._getEffectiveChildren(context),
            ],
          ),
        ),
      ),
    );
  }
}
