import 'package:flutter/material.dart';

import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';

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
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(color: color),
          ),
        ],
      ),
      if (showArrow)
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: color.withOpacity(0.5),
          size: NumericConstants.listElementIconSize,
        ),
    ];

    return result;
  }

  static Widget builder(BuildContext context, HeliosListElement element) =>
      LayoutBuilder(
        builder: (context, constaints) {
          return SizedBox(
            height: NumericConstants.listElementHeight,
            width: constaints.maxWidth,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: element.onTap != null
                    ? () => element.onTap!(context)
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: element._effectiveChildren(context),
                ),
              ),
            ),
          );
        },
      );
}
