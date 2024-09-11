import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio dio = Dio(BaseOptions(
  baseUrl: dotenv.get("MASTER_BACKEND_URL", fallback: "localhost"),
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
  validateStatus: (status) => true,
));
