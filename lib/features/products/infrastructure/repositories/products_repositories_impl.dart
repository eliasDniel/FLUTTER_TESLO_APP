




import 'package:flutter_teslo_app/features/products/domain/datasources/products_datasource.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';
import 'package:flutter_teslo_app/features/products/domain/repositories/products_repositories.dart';

class ProductsRepositoriesImpl extends ProductsRepositories{
  final ProductsDatasource productsDatasource;
  ProductsRepositoriesImpl(this.productsDatasource);

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return productsDatasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return productsDatasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int offset = 0, int limit = 10}) {
    return productsDatasource.getProductsByPage(offset: offset, limit: limit);
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    return productsDatasource.searchProductsByTerm(term);
  }
}