import 'package:Helios/common/interafces/basic_response.dart';

class ErrorResponse implements BasicResponse {
  ErrorResponse({
    required this.message,
    required this.error,
  });

  final String? error;
  @override
  final String message;
}
