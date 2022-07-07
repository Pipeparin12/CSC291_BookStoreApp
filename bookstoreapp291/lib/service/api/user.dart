import 'package:bookstoreapp291/service/dio.dart';

class UserApi {
  static Future<dynamic> signIn(String email, String password) async {
    var response = await DioInstance.dio
        .post("/auth/signin", data: {"email": email, "password": password});
  }

  static Future<dynamic> signUp(String email, String password) async {
    var response = await DioInstance.dio
        .post('/auth/signup', data: {"email": email, "password": password});
  }
}
