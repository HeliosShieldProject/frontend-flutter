import 'package:Helios/common/interafces/basic_response.dart';

class Response implements BasicResponse {
  Response({
    required this.message,
    required this.data,
  });

  final Object? data;
  @override
  final String message;
}
