import 'package:flutter/material.dart';

import 'package:Helios/common/ui/utils/blank_spacer.dart';

import 'package:Helios/common/constants/literals.dart';

SnackBar snackBar(BuildContext context,
    {required String title, Duration duration = const Duration(seconds: 10)}) {
  final ThemeData themeData = Theme.of(context);
  final TextTheme textTheme = themeData.textTheme;

  return SnackBar(
    backgroundColor: Colors.red,
    content: Row(
      children: <Widget>[
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
        blankSpacerH(),
        Text(
          title,
          style: textTheme.labelMedium,
        ),
      ],
    ),
    action: SnackBarAction(
      label: Literals.authSnackBar,
      textColor: Colors.white,
      onPressed: () {},
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    duration: duration,
  );
}
