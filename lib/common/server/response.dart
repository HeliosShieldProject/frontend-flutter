import 'package:Helios/common/enums/enums.dart';

abstract interface class BasicResponse {
  BasicResponse({
    required this.message,
  });

  final String message;
}

class Response extends BasicResponse {
  Response({
    required super.message,
    required this.data,
  });

  final Object? data;
}

class ErrorResponse extends BasicResponse {
  ErrorResponse({
    required super.message,
    required this.error,
  });

  final String? error;
}

Response responseMapper({required Map<String, dynamic> json}) {
  return Response(
    message: json["message"].toString(),
    data: json.containsKey("data") ? json["data"] : null,
  );
}

ErrorResponse errorResponseMapper({required Map<String, dynamic> json}) {
  return ErrorResponse(
    message: json["message"].toString(),
    error: json["error"].toString(),
  );
}

abstract interface class BasicServerEntity {
  BasicServerEntity(this.status);

  final Auth status;
}
