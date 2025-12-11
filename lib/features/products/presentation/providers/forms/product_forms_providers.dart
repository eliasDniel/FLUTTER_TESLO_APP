import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/config/constants/enviroment.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';
import 'package:flutter_teslo_app/features/products/products.dart';
import 'package:formz/formz.dart';
import '../../../../shared/infrastructure/infrastruture.dart';

//* PROVIDER DEL FORMULARIO DE PRODUCTO */
final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
      final createUpdateCallBack = ref
          .watch(productsProvider.notifier)
          .createUpdateProduct;

      return ProductFormNotifier(
        product: product,
        onSubmit: createUpdateCallBack,
      );
    });

//* NOTIFIER DEL FORMULARIO DE PRODUCTO
class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)? onSubmit;
  ProductFormNotifier({this.onSubmit, required Product product})
    : super(
        ProductFormState(
          id: product.id,
          title: Title.dirty(product.title),
          slug: Slug.dirty(product.slug),
          price: Price.dirty(product.price),
          inStock: Stock.dirty(product.stock),
          sizes: product.sizes,
          gender: product.gender,
          description: product.description,
          tags: product.tags.join(', '),
          images: product.images,
        ),
      );

  Future<bool> onFormSubmit() async {
    _toogleEverythingIsValid();
    if (!state.isFormValid) return false;

    if (onSubmit == null) return false;

    final productLike = <String, dynamic>{
      'id': (state.id == 'new') ? null : state.id,
      'title': state.title.value,
      'slug': state.slug.value,
      'price': state.price.value,
      'sizes': state.sizes,
      'gender': state.gender,
      'description': state.description,
      'tags': state.tags.split(',').map((e) => e.trim()).toList(),
      'stock': state.inStock.value,
      'images': state.images
          .map(
            (image) =>
                image.replaceAll("${Enviroment.apiUrl}/files/products", ''),
          )
          .toList(),
    };

    try {
      return await onSubmit!(productLike);
    } catch (e) {
      return false;
    }
  }

  void _toogleEverythingIsValid() {
    final isValid = Formz.validate([
      Title.dirty(state.title.value),
      Slug.dirty(state.slug.value),
      Price.dirty(state.price.value),
      Stock.dirty(state.inStock.value),
    ]);
    state = state.copyWith(isFormValid: isValid);
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Slug.dirty(value),
        Title.dirty(state.title.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Price.dirty(value),
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Stock.dirty(value),
        Title.dirty(state.title.value),
        Price.dirty(state.price.value),
        Slug.dirty(state.slug.value),
      ]),
    );
  }

  void onSizesChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

//* ESTADO DEL FORMULARIO DE PRODUCTO
class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final String description;
  final String tags;
  final Stock inStock;
  final List<String> images;
  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.description = '',
    this.tags = '',
    this.inStock = const Stock.dirty(0),
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    String? description,
    String? tags,
    Stock? inStock,
    List<String>? images,
  }) {
    return ProductFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
      gender: gender ?? this.gender,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      inStock: inStock ?? this.inStock,
      images: images ?? this.images,
    );
  }
}
