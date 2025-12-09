import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProductsByPage({int offset = 0, int limit = 10});
  Future<Product> getProductById(String id);
  Future<List<Product>> searchProductsByTerm(String term);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
