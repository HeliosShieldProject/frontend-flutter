import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:Helios/common/constants/numeric_constants.dart';

import 'package:Helios/features/register_sign_in/domain/utils/text_size.dart';

class UnderButtonText extends StatefulWidget {
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
  State<UnderButtonText> createState() => _UnderButtonTextState();
}

class _UnderButtonTextState extends State<UnderButtonText> {
  late final TapGestureRecognizer tapGestureRecognizer;

  @override
  void initState() {
    super.initState();

    tapGestureRecognizer = TapGestureRecognizer();
    tapGestureRecognizer.onTap = widget.onTap;
  }

  @override
  void dispose() {
    tapGestureRecognizer.dispose();

    super.dispose();
  }

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
              "${widget.firstText} ${widget.secondText}",
              textTheme.labelMedium!,
            ).height,
      ),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: "${widget.firstText} ",
              style: textTheme.labelMedium!.copyWith(
                color: colorScheme.onSurface.withOpacity(
                  0.5,
                ),
              ),
            ),
            TextSpan(
              recognizer: tapGestureRecognizer,
              text: widget.secondText,
              style: textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
