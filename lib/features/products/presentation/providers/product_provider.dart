import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';
import '../../domain/repositories/products_repositories.dart';
import 'products_repository_provider.dart';

//* Provider que maneja el estado de un solo producto */
final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
      final productsRepository = ref.watch(productsRepositoryProviders);
      return ProductNotifier(
        productsRepository: productsRepository,
        productId: productId,
      );
    });

//* Notifier de un solo producto */
class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;
  ProductNotifier({required this.productsRepository, required String productId})
    : super(ProductState(productId: productId)) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      slug: '',
      price: 0,
      sizes: [],
      description: '',
      stock: 0,
      gender: '',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.productId == 'new') {
        state = state.copyWith(isLoading: false, product: newEmptyProduct());
        return;
      }
      final product = await productsRepository.getProductById(state.productId);
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      print('Error loading product: $e');
    }
  }
}

//* Estado de un solo producto
class ProductState {
  final String productId;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.productId,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? productId,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
      productId: productId ?? this.productId,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
