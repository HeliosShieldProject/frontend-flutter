import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

ThemeData getTheme(SelectedTheme? theme) => switch (theme) {
      (SelectedTheme.system) =>
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? darkTheme
            : lightTheme,
      (SelectedTheme.dark) => darkTheme,
      (SelectedTheme.light) => lightTheme,
      (null) => throw ("Unknown behaviour"),
    };
