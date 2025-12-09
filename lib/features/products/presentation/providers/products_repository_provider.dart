import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/products/domain/repositories/products_repositories.dart';
import 'package:flutter_teslo_app/features/products/infrastructure/infrastructure.dart';

import '../../../auth/presentation/providers/providers.dart';

final productsRepositoryProviders = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final productRepository = ProductsRepositoriesImpl(ProductDatasourcesImpl(
    accessToken: accessToken,
  ));
  return productRepository;
});
