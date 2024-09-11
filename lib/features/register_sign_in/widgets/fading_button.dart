import 'package:flutter/material.dart';
import 'package:Helios/common/ui/elements/elements.dart';

/// The button, that will be fading according to the [fadeAnimation]
///
/// [shouldStartFading] determins whether the button should start fading according to the [fadeAnimation]
/// if not true, transparent container of the same size as the button will be returned
///
/// [onTap] - callback on tap of the button, if not specified, the button
/// is assumed as disabled and thus the color of the button is applied with
/// opacity(0.5)
///
/// [label] - text label of the button, uses labelMedium TextStyle from context's ThemeData
class FadingButton extends StatelessWidget {
  const FadingButton({
    super.key,
    this.onTap,
    this.label,
    required bool shouldStartFading,
    required Animation<double> fadeAnimation,
  })  : _shouldStartFading = shouldStartFading,
        _fadeAnimation = fadeAnimation;

  final bool _shouldStartFading;
  final Animation<double> _fadeAnimation;
  final String? label;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _shouldStartFading
        ? FadeTransition(
            opacity: _fadeAnimation,
            child: HeliosButton(
              onTap: onTap,
              label: label,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        : Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
          );
  }
}
