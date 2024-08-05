import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int price,
  }) : super(
          description: description,
          id: id,
          imageUrl: imageUrl,
          name: name,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['data'][0]['id'],
        name: json['data'][0]['name'],
        description: json['data'][0]['description'],
        imageUrl: json['data'][0]['imageUrl'],
        price: json['data'][0]['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
      };

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        price: price,
      );
}
