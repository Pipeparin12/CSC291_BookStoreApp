import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/service/share_preference.dart';
import 'package:dio/dio.dart';

class BookApi {
  static Future<dynamic> addBook(
      // String bookName, String bookDes, int bookAmount, String bookImage,
      FormData formData) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.post("/book/add", data: formData);
  }

  static Future<dynamic> getAllBook() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get('/book/all-book');
    return response;
  }

  static Future<dynamic> getBook(String bookId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/book/$bookId");
    return response;
  }

  static Future<dynamic> getYourBook() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get(
      '/book/user/yourbook',
    );
    return response;
  }

  static Future<dynamic> updateBook(String bookId, String bookName,
      String bookDes, int bookAmount, String imageUrl) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.patch('/book/$bookId', data: {
      "bookName": bookName,
      "bookDescription": bookDes,
      "bookAmount": bookAmount,
      "bookImage": imageUrl
    });
    return response;
  }

  static Future<dynamic> deleteBook(String bookId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.delete('/book/$bookId');
    return response;
  }

  static Future<dynamic> searchBook(String bookName) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/search/$bookName");
    return response;
  }
}
