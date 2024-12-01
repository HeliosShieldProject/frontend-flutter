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

  void _handleChange(bool val, VpnBloc bloc) => val
      ? bloc.add(
          VpnConnectionExecutedEvent(
            country: CountriesConstants.uk,
            protocol: Protocols.vless,
          ),
        )
      : bloc.add(
          VpnConnectionDisconnectedEvent(),
        );

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
      (newState.state == States.error || newState.state == States.loading);

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
                  child: HeliosConnectButton(
                    state: state.state ?? States.loading,
                    onChange: (val) => _handleChange(
                      val,
                      context.read<VpnBloc>(),
                    ),
                    duration: const Duration(milliseconds: 500),
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
