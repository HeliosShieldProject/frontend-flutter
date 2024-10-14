import 'package:flutter/material.dart';

import 'package:Helios/common/constants/numeric_constants.dart';

import 'package:Helios/features/register_sign_in/domain/utils/text_size.dart';

class UnderButtonText extends StatelessWidget {
  const UnderButtonText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    final ColorScheme colorScheme = themeData.colorScheme;
    final TextTheme textTheme = themeData.textTheme;

    return Transform.translate(
      offset: Offset.fromDirection(
        NumericConstants.pi / 2,
        NumericConstants.spacerSize +
            textSize(
              "$firstText $secondText",
              textTheme.labelMedium!,
            ).height,
      ),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: "$firstText ",
              style: textTheme.labelMedium!.copyWith(
                color: colorScheme.onSurface.withOpacity(
                  0.5,
                ),
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Text(
                  secondText,
                  style: textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
