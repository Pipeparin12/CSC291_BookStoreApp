import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/service/share_preference.dart';

class BookmarkApi {
  static Future<dynamic> getBookmark() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/bookmark/get-bookmark");
    return response;
  }

  static Future<dynamic> addToBookmark(
      String bookName, int bookAmount, String bookImage, String bookId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response =
        await DioInstance.dio.post("/bookmark/add-bookmark/$bookId", data: {
      "bookName": bookName,
      "bookImage": bookImage,
      "bookAmount": bookAmount,
    });
  }
}
