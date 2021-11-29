import 'package:dio/dio.dart';
import 'package:hf/constants/strings.dart';

class ServiceManager {
  late Dio dio;

  ServiceManager() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
}
