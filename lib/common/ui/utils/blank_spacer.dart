import 'package:flutter/widgets.dart';

/// Basic transparent Spacer, 10 px in height
/// Can be multiplied via the provided [multiplier] argument
Widget blankSpacer({double multiplier = 1}) => SizedBox(
      height: (10 * multiplier),
    );
