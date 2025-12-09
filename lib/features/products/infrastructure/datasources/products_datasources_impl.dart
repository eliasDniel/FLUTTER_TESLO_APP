import 'package:dio/dio.dart';
import 'package:flutter_teslo_app/config/config.dart';
import 'package:flutter_teslo_app/features/products/domain/datasources/products_datasource.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';
import 'package:flutter_teslo_app/features/products/infrastructure/mappers/products_mappers.dart';

class ProductDatasourcesImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;
  ProductDatasourcesImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Enviroment.apiUrl,
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage({
    int offset = 0,
    int limit = 10,
  }) async {
    final response = await dio.get<List>(
      '/api/products?limit=$limit&offset=$offset',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    final List<Product> products = [];
    for (var element in response.data ?? []) {
      products.add(ProductsMappers.jsonToEntity(element));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductsByTerm(String term) {
    // TODO: implement searchProductsByTerm
    throw UnimplementedError();
  }
}
