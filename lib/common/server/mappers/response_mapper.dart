import 'package:Helios/common/server/dto/response.dart';

Response responseMapper({required Map<String, dynamic> json}) {
  return Response(
    message: json["message"].toString(),
    data: json.containsKey("data") ? json["data"] : null,
  );
}
