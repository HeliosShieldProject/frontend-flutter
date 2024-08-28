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

enum RefreshStatus {
  failed,
  success,
}

class Server {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.get("MASTER_BACKEND_URL", fallback: "localhost"),
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => true,
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

  static Future<Map<String, dynamic>> refresh({required User user}) async {
    var headers = {
      "Authorization": "Bearer ${user.jwtRefreshToken}",
    };

    final result = await dio.request(
      "auth/refresh",
      options: Options(
        headers: headers,
      ),
    );

    return switch (result.statusCode) {
      200 => result.data,
      401 => {"data": RefreshStatus.failed},
      int() => {"data": RefreshStatus.failed},
      null => {"data": RefreshStatus.failed},
    };
  }

  static Future<Map<String, dynamic>> signIn({required User user}) async {
    final result = await dio.request(
      "/auth/sign-in",
      data: user.toJson(),
      options: Options(
        method: "POST",
      ),
    );

    return switch (result.statusCode) {
      200 => result.data,
      404 => {"data": SignInStatus.userNotFound},
      401 => {"data": SignInStatus.wrongPassword},
      int() => {"data": SignInStatus.failed},
      null => {"data": SignInStatus.failed},
    };
  }

  static Future<Map<String, dynamic>> signUp({required User user}) async {
    final result = await dio.request(
      "/auth/sign-up",
      data: user.toJson(),
      options: Options(
        method: "POST",
      ),
    );

    return switch (result.statusCode) {
      201 => result.data,
      409 => {"data": SignUpStatus.userExists},
      int() => {"data": SignUpStatus.failed},
      null => {"data": SignUpStatus.failed},
    };
  }
}
