import 'package:flutter_teslo_app/config/constants/enviroment.dart';
import 'package:flutter_teslo_app/features/products/domain/entities/product.dart';

import '../../../auth/infrastructure/mappers/user_mapper.dart';

class ProductsMappers {
  static jsonToEntity(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: double.parse(json["price"].toString()),
    description: json["description"],
    slug: json["slug"],
    stock: json["stock"],
    sizes: List<String>.from(json["sizes"].map((size) => size)),
    gender: json["gender"],
    tags: List<String>.from(json["tags"].map((tag) => tag)),
    images: List<String>.from(
      json["images"].map(
        (String image) => image.startsWith('http')
            ? image
            : '${Enviroment.apiUrl}/files/product/$image',
      ),
    ),

    user: UserMapper.userJsonToEntity(json["user"]),
  );
}
