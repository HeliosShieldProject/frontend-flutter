import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:Helios/features/vpn_app/domain/bloc/vpn_bloc/vpn_bloc.dart';

class HeliosConnectButton extends StatelessWidget {
  const HeliosConnectButton({
    super.key,
    required this.state,
    required this.onChange,
    required this.duration,
  });

  final States state;
  final void Function(bool) onChange;
  final Duration duration;

  double get _effectiveOpacity =>
      (state != States.loading && state != States.error) ? 1.0 : 0.5;

  CrossFadeState get _effectiveCrossFadeState => state != States.connected
      ? CrossFadeState.showFirst
      : CrossFadeState.showSecond;

  Widget _firstChild(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _handleChange(true),
      child: SvgPicture.asset(
        "assets/images/disconnected_shield_icon.svg",
        fit: BoxFit.fitHeight,
        height: NumericConstants.connectionButtonHeight,
        colorFilter: ColorFilter.mode(
          colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget get _secondChild => GestureDetector(
        onTap: () => _handleChange(false),
        child: SvgPicture.asset(
          "assets/images/connected_shield_icon.svg",
          fit: BoxFit.fitHeight,
          height: NumericConstants.connectionButtonHeight,
        ),
      );

  void _handleChange(bool val) {
    if (state != States.loading && state != States.error) {
      onChange(val);
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: _effectiveOpacity,
        child: AnimatedCrossFade(
          firstChild: _firstChild(context),
          secondChild: _secondChild,
          crossFadeState: _effectiveCrossFadeState,
          duration: duration,
        ),
      );
}
