import 'package:flutter/material.dart';

import 'package:Helios/common/ui/elements/helios_button.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';

import 'package:Helios/common/constants/multipliers.dart';
import 'package:Helios/common/constants/numeric_constants.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.buttonLabel,
    required this.dialogTitle,
  });

  final String buttonLabel;
  final String dialogTitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.tertiary,
          borderRadius: BorderRadius.circular(
            NumericConstants.borderRadius,
          ),
        ),
        padding: const EdgeInsets.all(NumericConstants.horizontalPadding),
        child: Column(
          children: <Widget>[
            Text(
              dialogTitle,
              style: textTheme.titleLarge!.copyWith(color: Colors.white),
            ),
            const BlankSpacer(
              multiplier: Multipliers.heliosListTileDivider2BlankSpacer,
            ),
            HeliosButton(
              label: buttonLabel,
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
