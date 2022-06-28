import 'package:bookstoreapp291/model/product.dart';

abstract class BaseProductService {
  Stream<List<Product>> getAllProducts();
}
