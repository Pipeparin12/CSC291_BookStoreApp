import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/service/dio.dart';

class BookApi {
  static Future<dynamic> addBook(
      String bookName, String bookDes, int bookAmount, String bookImage) async {
    var response = await DioInstance.dio.post("/book/add", data: {
      "bookName": bookName,
      "bookDescription": bookDes,
      "bookAmount": bookAmount,
      "bookImage": bookImage
    });
  }

  static Future<dynamic> getAllBook() async {
    final response = await DioInstance.dio.get('/book/all-book');
    return response;
  }
}
