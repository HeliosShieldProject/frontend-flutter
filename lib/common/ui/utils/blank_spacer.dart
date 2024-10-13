import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:flutter/widgets.dart';

/// Basic transparent Spacer, 10 px in height
/// Can be multiplied via the provided [multiplier] argument
Widget blankSpacerV({double multiplier = 1}) => SizedBox(
      height: (NumericConstants.spacerSize * multiplier),
    );

Widget blankSpacerH({double multiplier = 1}) => SizedBox(
      width: (NumericConstants.spacerSize * multiplier),
    );
