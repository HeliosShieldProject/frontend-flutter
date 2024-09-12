import 'package:Helios/common/server/dto/error_response.dart';

ErrorResponse errorResponseMapper({required Map<String, dynamic> json}) {
  return ErrorResponse(
    message: json["message"].toString(),
    error: json["error"].toString(),
  );
}
