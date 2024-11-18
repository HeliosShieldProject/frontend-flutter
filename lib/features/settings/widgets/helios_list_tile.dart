import 'package:Helios/common/constants/multipliers.dart';
import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:flutter/material.dart';

class HeliosListTile<T> extends StatelessWidget {
  const HeliosListTile({
    super.key,
    this.titleWidget,
    required this.children,
    required this.builder,
  });

  final Widget? titleWidget;
  final List<T> children;

  final Widget Function(T) builder;

  List<Widget> _effectiveChildren(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final List<Widget> result = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      result.addAll(
        <Widget>[
          builder(children[i]),
          BlankSpacer(
            multiplier: Multipliers.heliosListTileDivider2BlankSpacer,
            child: Divider(
              thickness: 2,
              color: colorScheme.onTertiary,
            ),
          ),
        ],
      );
    }

    result.removeLast();

    if (titleWidget != null) {
      result.addAll(
        <Widget>[
          titleWidget!,
          const BlankSpacer(
            multiplier: Multipliers.heliosListTileDivider2BlankSpacer,
          ),
        ],
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(NumericConstants.borderRadius),
      ),
      padding: const EdgeInsets.all(NumericConstants.horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _effectiveChildren(context),
      ),
    );
  }
}
