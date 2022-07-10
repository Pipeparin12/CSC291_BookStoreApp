import 'package:dio/dio.dart';

class DioInstance {
  static late Dio dio;
  static String baseUrl = 'http://10.0.2.2:8080';

  // getImage("avatars/sdfsdfsdf.jpg") -> http://10.0.2.2:8080/storage/avatars/sadfsdfsdf.
  static String getImage(String url) {
    if (url.startsWith("https://")) return url;
    return baseUrl + "/storage/$url";
  }

  static void init() async {
    var options = BaseOptions(
      baseUrl: baseUrl,
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
