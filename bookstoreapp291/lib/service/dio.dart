import 'package:dio/dio.dart';

class DioInstance {
  static late Dio dio;
  static void init() async {
    var options = BaseOptions(
      baseUrl: 'http://10.0.2.2:8080',
      contentType: "application/json",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    try {
      dio = Dio(options);
      print("Dio is ready");
    } catch (e) {
      print(e);
    }
  }
}
