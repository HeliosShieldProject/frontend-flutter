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

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<VpnBloc, VpnState>(
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
                height: NumericConstants.appBarElementSize,
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
                  size: NumericConstants.appBarElementSize + 5,
                ),
                onPressed: () => _onTapAppBar(context),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: NumericConstants.horizontalPadding,
            right: NumericConstants.horizontalPadding,
            bottom: NumericConstants.bottomPadding,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: HeliosConnectionButton(
                    state: state.state ?? States.loading,
                    duration: const Duration(milliseconds: 1000),
                    onTap: (state) {
                      if (state == States.connected) {
                        context.read<VpnBloc>().add(
                              VpnConnectionExecutedEvent(
                                country: CountriesConstants.uk,
                                protocol: Protocols.ss,
                              ),
                            );
                      } else if (state == States.disconnected) {
                        context.read<VpnBloc>().add(
                              VpnConnectionDisconnectedEvent(),
                            );
                      }
                    },
                    primary: colorScheme.primary,
                    secondary: colorScheme.secondary,
                  ),
                ),
              ),
              HeliosVpnCard(
                connected: state.state == States.connected,
                currentCountry: state.country,
                uploadSpeed: state.uploadSpeed,
                downloadSpeed: state.downloadSpeed,
                countryIp: state.ip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeliosConnectionButton extends StatelessWidget {
  HeliosConnectionButton({
    super.key,
    required this.state,
    required this.duration,
    required this.onTap,
    required this.primary,
    required this.secondary,
  });

  final States state;
  final Duration duration;
  final Color primary;
  final Color secondary;
  final void Function(States state) onTap;

  void _handleTap(States state) {
    if (this.state != States.loading && this.state != States.error) {
      onTap(state);
    }
  }

  late final Widget firstChild = GestureDetector(
    onTap: () => _handleTap(States.connected),
    child: SvgPicture.asset(
      "assets/images/disconnected_shield_icon.svg",
      height: NumericConstants.connectionButtonHeight,
      fit: BoxFit.fitHeight,
    ),
  );
  late final Widget secondChild = GestureDetector(
    onTap: () => _handleTap(States.disconnected),
    child: SvgPicture.asset(
      "assets/images/connected_shield_icon.svg",
      height: NumericConstants.connectionButtonHeight,
      fit: BoxFit.fitHeight,
    ),
  );

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: (state == States.error || state == States.loading) ? 0.5 : 1.0,
        child: AnimatedCrossFade(
          firstChild: firstChild,
          secondChild: secondChild,
          crossFadeState: state == States.connected
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: duration,
        ),
      );
}
