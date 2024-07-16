import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:helios/common/theme/theme.dart';

abstract interface class UserSettings {
  SubscriptionType? subscriptionType;
  SelectedTheme? selectedTheme;

  MyTheme get theme;
} 

class UserSettingsImpl implements UserSettings {
  @override
  SelectedTheme? selectedTheme;

  @override
  SubscriptionType? subscriptionType = SubscriptionType.free;

  @override
  MyTheme get theme {
    switch(selectedTheme) {
      case(null):
        return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? darkTheme : lightTheme;
      case SelectedTheme.dark:
        return darkTheme;
      case SelectedTheme.light:
        return lightTheme;
    }
  }
}

enum SubscriptionType {
  free, 
  premium,
  superPremium, 
}

enum SelectedTheme {
  dark,
  light,
}