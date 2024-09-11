import 'package:flutter/material.dart';

/// Helios Button compliant to the design patterns of the Helios app
///
/// [onTap] - callback on tap of the button, if not specified, the button
/// is assumed as disabled and thus the color of the button is applied with
/// opacity(0.5)
///
/// [label] - text label of the button, uses labelMedium TextStyle from context's ThemeData
///
/// [labelWidget] - Widget, that will be used instead of the label text.
///
/// !!Either [label] or [labelWidget] should be specified
///
/// [color] - color of the button
///
/// [gradient] - gradient that will be applied to the button
///
/// !!Either [color] or [gradient] should be specified
class HeliosButton extends StatelessWidget {
  const HeliosButton({
    super.key,
    this.onTap,
    this.label,
    this.labelWidget,
    this.color,
    this.gradient,
  })  : assert(
            color != null && gradient == null ||
                color == null && gradient != null,
            "Either color or gradient should be provided"),
        assert(
            label == null && labelWidget != null ||
                label != null && labelWidget == null,
            "Either label or labelWidget should be provided");

  final String? label;
  final Widget? labelWidget;
  final Color? color;
  final Gradient? gradient;
  final GestureTapCallback? onTap;

  Widget effectiveTitle(BuildContext context) {
    return label != null
        ? Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium,
          )
        : labelWidget!;
  }

  Color? get effectiveColor => onTap != null ? color : color?.withOpacity(0.5);

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
              color: effectiveColor,
              gradient: gradient,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: effectiveTitle(context),
                ),
                InkWell(
                  splashColor:
                      Theme.of(context).colorScheme.background.withOpacity(0.7),
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
