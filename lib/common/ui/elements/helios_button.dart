import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class HeliosButton extends StatelessWidget {
  const HeliosButton({
    super.key,
    this.onTap,
    this.label,
    this.color,
    this.gradient,
  }) : assert(
            color != null && gradient == null ||
                color == null && gradient != null,
            "Either color or gradient should be provided");

  final String? label;
  final Color? color;
  final Gradient? gradient;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: Ink(
            decoration: BoxDecoration(
              color: onTap != null ? color : color?.withOpacity(0.5),
              gradient: gradient,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  label ?? "",
                  style: AppTheme.of(context).themeData.textTheme.labelMedium,
                ),
                InkWell(
                  splashColor: AppTheme.of(context)
                      .themeData
                      .colorScheme
                      .background
                      .withOpacity(0.7),
                  onTap: onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FadingButton extends StatelessWidget {
  const FadingButton({
    super.key,
    required this.onTap,
    this.label,
    required bool shouldStartFading,
    required Animation<double> fadeAnimation,
  })  : _shouldStartFading = shouldStartFading,
        _fadeAnimation = fadeAnimation;

  final bool _shouldStartFading;
  final Animation<double> _fadeAnimation;
  final String? label;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _shouldStartFading
        ? FadeTransition(
            opacity: _fadeAnimation,
            child: HeliosButton(
              onTap: onTap,
              label: label,
              color: AppTheme.of(context).themeData.colorScheme.onBackground,
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
