import 'package:hive/hive.dart';

part '../../repositories/local_repository/user_settings/generated/enums.g.dart';

enum Auth {
  success,
  failed,
  wrongToken,
  wrongPassword,
  userNotFound,
  userAlreadyExists,
  passwordIsSame,
  oAuthFailed,
  oAuthDifferentEmail,
  noClassicAuth,
}

enum UserValidity {
  needsRefreshment,
  notValid,
}

@HiveType(typeId: 1)
enum SubscriptionType {
  @HiveField(0)
  free,

  @HiveField(1)
  premium,

  @HiveField(2)
  superPremium,
}

@HiveType(typeId: 2)
enum SelectedTheme {
  @HiveField(0)
  system,

  @HiveField(1)
  dark,

  @HiveField(2)
  light,
}
