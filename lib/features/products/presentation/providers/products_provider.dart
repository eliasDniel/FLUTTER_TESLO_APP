
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';
import 'package:flutter_teslo_app/features/products/presentation/providers/providers.dart';
import '../../domain/repositories/products_repositories.dart';

//* Provider que maneja el estado de los productos
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) {
    final productsRepository = ref.watch(productsRepositoryProviders);
    return ProductsNotifier(productsRepository: productsRepository);
  },
);

//* Notifier que maneja el estado de los productos
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;
  ProductsNotifier({required this.productsRepository})
    : super(ProductsState()) {
    loadNextPage();
  }

  Future<bool> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await productsRepository.createUpdateProduct(productLike);
      final isProductInList = state.products.any((p) => p.id == product.id);
      if (!isProductInList) {
        state = state.copyWith(products: [product, ...state.products]);
        return true;
      }
      state = state.copyWith(
        products: state.products
            .map((element) => element.id == product.id ? product : element)
            .toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  //* Lógica para manejar el estado de los productos
  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);
    final products = await productsRepository.getProductsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (products.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + state.limit,
      products: [...state.products, ...products],
    );
  }
}

//* Estado de los productos(lista de productos, paginacion, etc)
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) {
    return ProductsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
