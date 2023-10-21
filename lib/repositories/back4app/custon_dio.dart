import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarefa_app/repositories/back4app/dio_interceptor.dart';

class CustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  CustonDio() {
    _dio.options.headers["content-type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4AppInterceptor());
  }
}
