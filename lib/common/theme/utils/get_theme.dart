import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:Helios/common/enums/enums.dart';

ThemeMode getThemeMode(SelectedTheme? theme) => switch (theme) {
      (SelectedTheme.system) =>
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
      (SelectedTheme.dark) => ThemeMode.dark,
      (SelectedTheme.light) => ThemeMode.light,
      (null) => throw ("Unknown behaviour"),
    };
