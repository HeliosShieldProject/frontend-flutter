import 'package:flutter/widgets.dart';

import 'package:Helios/common/constants/numeric_constants.dart';

/// Basic transparent Spacer, 10 px in height
/// Can be multiplied via the provided [multiplier] argument
///
/// Can be made horizontal if [horizontal] argument is set to true
///
/// If [child] argument is provided will position thus child in
/// it with [NumericConstants.spacerSize] padding from the top
class BlankSpacer extends StatelessWidget {
  const BlankSpacer({
    super.key,
    this.multiplier = 1,
    this.horizontal = false,
    this.child,
  });

  final double multiplier;
  final bool horizontal;
  final Widget? child;

  Widget get _effectiveSpacer => child == null
      ? SizedBox(
          width: horizontal ? (NumericConstants.spacerSize * multiplier) : null,
          height:
              !(horizontal) ? (NumericConstants.spacerSize * multiplier) : null,
        )
      : Center(
          child: Container(
            width:
                horizontal ? (NumericConstants.spacerSize * multiplier) : null,
            height: !(horizontal)
                ? (NumericConstants.spacerSize * multiplier)
                : null,
            padding: const EdgeInsets.only(
              top: NumericConstants.spacerSize,
            ),
            child: child,
          ),
        );

  @override
  Widget build(BuildContext context) => _effectiveSpacer;
}
