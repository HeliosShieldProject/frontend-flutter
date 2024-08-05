part of 'app_server.dart';

enum SignInStatus {
  userNotFound,
  wrongPassword,
  failed,
  success,
}

enum SignUpStatus {
  userExists,
  missingCredentialsOrDeviceInfo,
  failed,
  success,
}

class Server {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.get("MASTER_BACKEND_URL", fallback: "localhost"),
  ));

  static Future<void> changePassword({required String newPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  static Future<void> closeSession() {
    // TODO: implement closeSession
    throw UnimplementedError();
  }

  static Future<void> createSession() {
    // TODO: implement createSession
    throw UnimplementedError();
  }

  static Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  static Future<void> refresh() {
    throw UnimplementedError();
  }

  static Future<Map<String, dynamic>> signIn({required User user}) async {
    var result = await dio.request(
      "/auth/sign-in",
      data: jsonEncode(user.toJson()),
      options: Options(
        method: "POST",
      ),
    );

    return switch (result.statusCode) {
      200 => jsonDecode(result.data),
      400 => {"data": SignInStatus.userNotFound},
      401 => {"data": SignInStatus.wrongPassword},
      int() => {"data": SignInStatus.failed},
      null => {"data": SignInStatus.failed},
    };
  }

  static Future<Map<String, dynamic>> signUp({required User user}) async {
    var result = await dio.request(
      "/auth/sign-up",
      data: jsonEncode(user.toJson()),
      options: Options(
        method: "POST",
      ),
    );

    return switch (result.statusCode) {
      201 => jsonDecode(result.data),
      409 => {"data": SignUpStatus.userExists},
      400 => {"data": SignUpStatus.missingCredentialsOrDeviceInfo},
      int() => {"data": SignUpStatus.failed},
      null => {"data": SignUpStatus.failed},
    };
  }
}
