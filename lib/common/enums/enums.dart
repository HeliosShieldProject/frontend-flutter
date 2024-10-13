import 'package:Helios/common/constants/literals.dart';
import 'package:hive/hive.dart';

part '../../repositories/local_repository/user_settings/generated/enums.g.dart';

enum Auth {
  loading(name: Literals.loading),
  success(name: Literals.success),
  failed(name: Literals.failed),
  wrongToken(name: Literals.wrongToken),
  wrongPassword(name: Literals.wrongPassword),
  userNotFound(name: Literals.userNotFound),
  userAlreadyExists(name: Literals.userAlreadyExists),
  passwordIsSame(name: Literals.passwordIsSame),
  oAuthFailed(name: Literals.oAuthFailed),
  oAuthDifferentEmail(name: Literals.oAuthDifferentEmail),
  noClassicAuth(name: Literals.noClassicAuth);

  const Auth({
    required this.name,
  });

  final String name;
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
