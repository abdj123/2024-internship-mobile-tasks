import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
  }) : super(
          description: description,
          id: id,
          imageUrl: imageUrl,
          name: name,
          price: price,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['name'],
        name: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        imageUrl: json['weather'][0]['icon'],
        price: json['main']['temp'],
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
