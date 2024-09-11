part of 'app_server.dart';

class Server {
  static 

  static Future<void> changePassword(
      {required String newPassword, required User user}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  static Future<void> closeSession({required User user}) {
    // TODO: implement closeSession
    throw UnimplementedError();
  }

  static Future<Map<String, dynamic>> createSession(
      {required String country, required User user}) async {
    var headers = {
      "Authorization": "Bearer ${user.jwtToken}",
    };

    final result = await dio.request(
      "session",
      options: Options(
        method: "POST",
        headers: headers,
      ),
      data: {
        "country": country,
      },
    );

    return switch (result.statusCode) {
      200 => result.data,
      int() || null => {"data": CreateSessionStatus.failed},
    };
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
        method: "POST",
        headers: headers,
      ),
    );

    return switch (result.statusCode) {
      200 => result.data,
      int() || null => {"data": RefreshStatus.failed},
    };
  }

  static 

  static 
}
