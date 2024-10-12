import 'package:Helios/common/enums/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract interface class UserSettings extends Equatable {
  const UserSettings({
    required this.selectedTheme,
    required this.subscriptionType,
  });

  final SubscriptionType? subscriptionType;

  final SelectedTheme? selectedTheme;

  UserSettings copyWith({
    SubscriptionType? subscriptionType,
    SelectedTheme? selectedTheme,
  });
}
