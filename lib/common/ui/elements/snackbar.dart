import 'package:flutter/material.dart';

SnackBar snackBar(
  BuildContext context, {
  required String title,
  Duration duration = const Duration(seconds: 10),
}) =>
    SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
      action: SnackBarAction(
        label: "Понятно",
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
