part of "app_server.dart";

enum SignInStatus {
  failed,
  success,
  userNotFound,
  wrongPassword,
}

enum SignUpStatus {
  failed,
  success,
  userExists,
  missingCredentialsOrDeviceInfo,
}

enum RefreshStatus {
  failed,
  success,
}

enum CreateSessionStatus {
  failed,
  success,
}
