import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user_settings.dart';
import 'package:hive/hive.dart';

part '../generated/user_settings.g.dart';

@HiveType(typeId: 0)
class UserSettingsImpl implements UserSettings {
  const UserSettingsImpl({
    required this.selectedTheme,
    required this.subscriptionType,
  });

  @HiveField(0)
  @override
  final SelectedTheme? selectedTheme;

  @HiveField(1)
  @override
  final SubscriptionType? subscriptionType;

  const UserSettingsImpl.empty()
      : selectedTheme = null,
        subscriptionType = null;

  const UserSettingsImpl.basic()
      : selectedTheme = SelectedTheme.dark,
        subscriptionType = SubscriptionType.free;

  @override
  UserSettings copyWith({
    SubscriptionType? subscriptionType,
    SelectedTheme? selectedTheme,
  }) =>
      UserSettingsImpl(
        selectedTheme: selectedTheme ?? this.selectedTheme,
        subscriptionType: subscriptionType ?? this.subscriptionType,
      );

  @override
  List<Object?> get props => [
        selectedTheme,
        subscriptionType,
      ];

  @override
  bool? get stringify => true;
}
