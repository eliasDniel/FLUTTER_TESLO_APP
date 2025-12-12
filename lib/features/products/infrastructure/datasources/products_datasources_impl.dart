import 'package:dio/dio.dart';
import 'package:flutter_teslo_app/config/config.dart';
import 'package:flutter_teslo_app/features/products/domain/datasources/products_datasource.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';

import '../infrastructure.dart';

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

  Future<String> _uploadFile(String path) async {
    try {
      final fileName = path.split('/').last;
      final FormData formData = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName),
      });
      final response = await dio.post('/files/product', data: formData);
      return response.data['image'];
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  Future<List<String>> _upLoadPhotos(List<String> photos) async {
    final photosRoUpload = photos
        .where((element) => element.startsWith('/'))
        .toList();
    final phtosToIgnore = photos
        .where((element) => !element.startsWith('/'))
        .toList();

    final List<Future<String>> uploadJob = photosRoUpload
        .map(_uploadFile)
        .toList();
    final newImages = await Future.wait(uploadJob);
    return [...phtosToIgnore, ...newImages];
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = (productId == null)
          ? '/products'
          : '/products/$productId';
      productLike.remove('id');

      productLike['images'] = await _upLoadPhotos(productLike['images']);

      // throw Exception();
      final response = await dio.request(
        url,
        data: productLike,
        options: Options(method: method),
      );
      final product = ProductsMappers.jsonToEntity(response.data!);
      return product;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('/products/$id');
      final product = ProductsMappers.jsonToEntity(response.data!);
      return product;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        throw ProductNotFound();
      }
      throw Exception('Error al obtener el producto');
    } catch (e) {
      throw Exception('Error al obtener el producto');
    }
  }

  @override
  Future<List<Product>> getProductsByPage({
    int offset = 0,
    int limit = 10,
  }) async {
    final response = await dio.get<List>(
      '/products?limit=$limit&offset=$offset',
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
