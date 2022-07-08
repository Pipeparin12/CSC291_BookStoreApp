import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/service/share_preference.dart';

class BookApi {
  static Future<dynamic> addBook(
      String bookName, String bookDes, int bookAmount, String bookImage) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.post("/book/add", data: {
      "bookName": bookName,
      "bookDescription": bookDes,
      "bookAmount": bookAmount,
      "bookImage": bookImage
    });
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
}
