import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/service/share_preference.dart';

class CartApi {
  static Future<dynamic> getCart() async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.get("/cart/get-cart");
    return response;
  }

  static Future<dynamic> addToCart(String bookName, int amountInCart,
      String bookImage, String bookId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    var response = await DioInstance.dio.post("/cart/add-cart/$bookId", data: {
      "bookName": bookName,
      "bookImage": bookImage,
      "amountInCart": amountInCart,
    });
  }

  static Future<dynamic> deleteCart(String bookId) async {
    DioInstance.dio.options.headers["authorization"] =
        "Bearer " + SharePreference.prefs.getString("token").toString();
    final response = await DioInstance.dio.delete('/cart/remove/$bookId');
    return response;
  }
}
